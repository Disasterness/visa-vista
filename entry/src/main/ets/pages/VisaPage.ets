import { ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute, PromptAction } from '@kit.ArkUI'
import { CountryVisaInfo } from '../model/CountryVisaInfo'
import { VisaDataViewModel } from '../viewmodel/VisaDataViewModel'

interface ComparisonPageParams {
  selectedCountries: string,
  countries: CountryVisaInfo[]
}

@Builder
export function VisaPageBuilder() {
  VisaPage()
}

@Entry
@Component
struct VisaPage {
  @State countryList: CountryVisaInfo[] = []
  visaVm: VisaDataViewModel = new VisaDataViewModel();
  @State selectedCountryList: CountryVisaInfo[] = []
  @State maxSelectionReached: boolean = false

  pathStack: NavPathStack = new NavPathStack()
  promptAction: PromptAction = this.getUIContext().getPromptAction();

  aboutToAppear() {
    this.countryList = this.visaVm.getList()
  }

  handleSelectionChange(item: CountryVisaInfo, isChecked: boolean) {
    let newSelectedList = [...this.selectedCountryList]

    if (isChecked) {
      if (!newSelectedList.some(selected => selected.countryName === item.countryName)) {
        if (newSelectedList.length < 2) {
          newSelectedList.push(item)
        } else {
          this.maxSelectionReached = true
          this.promptAction.openToast({ message: 'Maximum 2 countries can be selected', duration: 2000 })
          return
        }
      }
    } else {
      newSelectedList = newSelectedList.filter(country => country.countryName !== item.countryName)
    }

    this.maxSelectionReached = newSelectedList.length >= 2
    this.selectedCountryList = newSelectedList
    console.info('Selected countries:', this.selectedCountryList.map(c => c.countryName))
  }

  navigateBasedOnSelection() {

    if (this.selectedCountryList.length === 1) {
      this.pathStack.pushPathByName('VisaDetailPage', this.selectedCountryList[0])
      return
    }

    if (this.selectedCountryList.length === 2) {
      const params: ComparisonPageParams = {
        selectedCountries: JSON.stringify(this.selectedCountryList),
        countries: this.selectedCountryList
      }
      this.pathStack.pushPathByName('ComparisonPage', params)
      return
    }

    this.promptAction.openToast({ message: 'Please select 1 or 2 countries', duration: 2000 })
  }

  isCheckboxDisabled(item: CountryVisaInfo): boolean {
    return !this.selectedCountryList.some(selected => selected.countryName === item.countryName) &&
    this.maxSelectionReached
  }

  build() {
    NavDestination() {
      Column() {
        Row() {
          Image($r('app.media.back_arrow'))
            .width(24)
            .height(24)
            .onClick(() => this.pathStack.pop())
        }
        .align(Alignment.Start)

        Text('Select Countries to Compare')
          .fontSize(14)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.White)
          .padding({left: 16, right: 16})
          .width('80%')

        ArcList({
          initialIndex: 0
        }) {
          ForEach(this.countryList, (item: CountryVisaInfo) => {
            ArcListItem() {
              this.buildCountryRow(item)
            }
            .width('80%')
            .margin({ bottom: 10})
          }, (item: CountryVisaInfo) => item.countryName);
        }
        .scrollBar(BarState.Off)
        .height('50%')
        .width('90%')

        Image($r('app.media.passport_compare'))
          .width(40)
          .height(40)
          .margin({ top: 10, bottom: 1})
          .align(Alignment.Center)
          .onClick(() => {
            this.navigateBasedOnSelection()
          })
      }
      .width('100%')
      .height('100%')
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
    .width('100%')
    .height('100%')
    .hideTitleBar(true)


  }

  @Builder
  buildCountryRow(item: CountryVisaInfo) {
    Row({ space: 0 }) {
      Image($r(`app.media.${item.mediaName}`))
        .width(20)
        .height(20)
        .margin({ right: 10 })

      Text(item.countryName)
        .fontSize(16)
        .fontColor(Color.Black)
        .width('60%')

      Checkbox({ name: `${item.countryName}Checkbox`, group: 'visaCompare' })
        .select(this.selectedCountryList.some(selected => selected.countryName === item.countryName))
        .selectedColor(0x007aff)
        .shape(CheckBoxShape.ROUNDED_SQUARE)
        .border({ width: 0.5, color: Color.Gray })
        .onChange((value: boolean) => {
          this.handleSelectionChange(item, value)
          console.info(`${item.countryName} selected: ${value}`)
        })
        .enabled(!this.isCheckboxDisabled(item))
    }
    .padding(10)
    .margin({ bottom: 10 })
    .backgroundColor(Color.White)
    .borderRadius(25)
    .border({ width: 0.5, color: Color.Gray })
    .align(Alignment.Center)
  }
}