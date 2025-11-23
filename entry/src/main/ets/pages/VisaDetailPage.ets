import { CountryVisaInfo } from '../model/CountryVisaInfo'

@Entry
@Component
struct VisaDetailPage {
  @State country: CountryVisaInfo = new CountryVisaInfo('Turkey', 54, 110, 55, 28, 'turkey')

  aboutToAppear() {
    const router = this.getUIContext().getRouter()
    const paramObject = router.getParams() as CountryVisaInfo

    console.error('tag', paramObject.countryName)
    this.country = paramObject
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.back_arrow'))
          .width(24)
          .height(24)
          .onClick(() => {
            this.getUIContext().getRouter().back()
          })
      }
      .align(Alignment.Start)

      Row({space: 10}) {
        Image($r(`app.media.${this.country.mediaName}`))
          .width(30)
          .height(30)
          .objectFit(ImageFit.Fill)

        Blank()

        Column({space: 4}) {
          Text(this.country.countryName)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .align(Alignment.Center)

          Text(`Ranking : ${this.country.passportRank}`)
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .align(Alignment.Center)
        }
      }
      .align(Alignment.Center)

      Column()
        .width('90%')
        .height(1)
        .alignSelf(ItemAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#ff807f7f')
        .margin({top: 10, bottom: 10})

      Column({space: 6}) {
        Row({space: 4}) {
          Circle().width(10).height(10).fill(Color.Green)
          Text(`No visa required : ${this.country.noVisaCountries}`).fontSize(14)
        }

        Row({space: 4}) {
          Circle().width(10).height(10).fill(Color.Red)
          Text(`Visa required : ${this.country.visaCountries}`).fontSize(14)
        }

        Row({space: 4}) {
          Circle().width(10).height(10).fill(Color.Yellow)
          Text(`E-Visa required : ${this.country.eVisaCountries}`).fontSize(14)
        }
      }
      .alignItems(HorizontalAlign.Start)
    }
    .margin({left : 14})
    .padding(10)
    .alignItems(HorizontalAlign.Center)
    .height('90%')
    .width('90%')
  }
}