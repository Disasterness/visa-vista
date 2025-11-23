import { ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute, prompt } from '@kit.ArkUI'
import { CountryVisaInfo } from '../model/CountryVisaInfo'
import { VisaDataViewModel } from '../viewmodel/VisaDataViewModel'

@Entry
@Component
struct VisaPage {
  @State countryList: CountryVisaInfo[] = []
  visaVm: VisaDataViewModel = new VisaDataViewModel();
  @State selectedCountryList: CountryVisaInfo[] = []
  @State maxSelectionReached: boolean = false

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
          prompt.showToast({ message: 'Maximum 2 countries can be selected', duration: 2000 })
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
    const r = this.getUIContext().getRouter()

    if (this.selectedCountryList.length === 1) {
      r.pushUrl({
        url: 'pages/VisaDetailPage',
        params: this.selectedCountryList[0]
      })
      return
    }

    if (this.selectedCountryList.length === 2) {
      r.pushUrl({
        url: 'pages/ComparisonPage',
        params: {
          selectedCountries: JSON.stringify(this.selectedCountryList),
          countries: this.selectedCountryList
        }
      })
      return
    }

    prompt.showToast({ message: 'Please select 1 or 2 countries', duration: 2000 })
  }

  isCheckboxDisabled(item: CountryVisaInfo): boolean {
    return !this.selectedCountryList.some(selected => selected.countryName === item.countryName) &&
    this.maxSelectionReached
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.back_arrow'))
          .width(24)
          .height(24)
          .onClick(() => this.getUIContext().getRouter().back())
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
        ForEach(this.countryList, (item: CountryVisaInfo, index) => {
          ArcListItem() {
            this.buildCountryRow(item)
          }
          .width('80%')
          .onClick(() => {})
          .margin({ bottom: 10})
        }, (item: string) => item);
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