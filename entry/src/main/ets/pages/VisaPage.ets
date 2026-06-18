import { ArcList, ArcListItem, PromptAction } from '@kit.ArkUI'
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
  @State filteredCountryList: CountryVisaInfo[] = []
  visaVm: VisaDataViewModel = new VisaDataViewModel();
  @State selectedCountryList: CountryVisaInfo[] = []
  @State maxSelectionReached: boolean = false
  @State isLoading: boolean = true
  @State searchText: string = ''

  pathStack: NavPathStack = new NavPathStack()
  promptAction: PromptAction = this.getUIContext().getPromptAction();

  async aboutToAppear() {
    this.isLoading = true;
    const context = getContext(this);
    this.countryList = await this.visaVm.fetchCountryList(context);
    this.filteredCountryList = this.countryList;
    this.isLoading = false;
  }

  handleSearch(text: string) {
    this.searchText = text;
    if (text.trim() === '') {
      this.filteredCountryList = this.countryList;
    } else {
      this.filteredCountryList = this.countryList.filter(country =>
        country.countryName.toLowerCase().includes(text.toLowerCase())
      );
    }
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
      Stack() {
        Column() {
          Row() {
            Image($r('app.media.back_arrow'))
              .width(24)
              .height(24)
              .onClick(() => this.pathStack.pop())
          }
          .align(Alignment.Start)
          .width('100%')
          .padding({ left: 16, top: 16 })

          Text('Select Countries to Compare')
            .fontSize(14)
            .fontWeight(FontWeight.Bolder)
            .fontColor(Color.White)
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .width('100%')
            .textAlign(TextAlign.Center)

          Search({ value: this.searchText, placeholder: 'Search country...' })
            .width('80%')
            .height(35)
            .backgroundColor('#33FFFFFF')
            .placeholderColor(Color.Gray)
            .textFont({ size: 14 })
            .onChange((value: string) => {
              this.handleSearch(value)
            })
            .margin({ bottom: 10 })

          if (this.isLoading) {
            Column() {
              LoadingProgress()
                .width(40)
                .height(40)
                .color(Color.White)
              Text('Loading data...')
                .fontSize(12)
                .fontColor(Color.White)
                .margin({ top: 8 })
            }
            .justifyContent(FlexAlign.Center)
            .layoutWeight(1)
          } else {
            ArcList({
              initialIndex: 0
            }) {
              ForEach(this.filteredCountryList, (item: CountryVisaInfo) => {
                ArcListItem() {
                  this.buildCountryRow(item)
                }
                .width('80%')
                .margin({ bottom: 10 })
              }, (item: CountryVisaInfo) => item.countryName + this.searchText);
            }
            .scrollBar(BarState.Off)
            .layoutWeight(1)
            .width('90%')

            Image($r('app.media.passport_compare'))
              .width(40)
              .height(40)
              .margin({ top: 10, bottom: 20 })
              .align(Alignment.Center)
              .onClick(() => {
                this.navigateBasedOnSelection()
              })
          }
        }
        .width('100%')
        .height('100%')
      }
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
        .layoutWeight(1)

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
    .backgroundColor(Color.White)
    .borderRadius(25)
    .border({ width: 0.5, color: Color.Gray })
    .align(Alignment.Center)
  }
}
