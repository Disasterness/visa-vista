import { CountryVisaInfo } from '../model/CountryVisaInfo'

@Builder
export function VisaDetailPageBuilder() {
  VisaDetailPage()
}

@Entry
@Component
struct VisaDetailPage {
  @State country: CountryVisaInfo = new CountryVisaInfo('Turkey', 54, 110, 55, 28, 'turkey', '')
  pathStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          Row() {
            Image($r('app.media.back_arrow'))
              .width(24)
              .height(24)
              .onClick(() => {
                this.pathStack.pop()
              })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Start)

          Row({ space: 10 }) {
            Image($r(`app.media.${this.country.mediaName}`))
              .width(40)
              .height(40)
              .objectFit(ImageFit.Contain)

            Column({ space: 4 }) {
              Text(this.country.countryName)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)

              Text(`Ranking : ${this.country.passportRank}`)
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.White)
            }
            .alignItems(HorizontalAlign.Start)
          }
          .margin({ top: 10 })
          .width('100%')
          .justifyContent(FlexAlign.Center)

          Divider()
            .vertical(false)
            .strokeWidth(1)
            .color('#ff807f7f')
            .margin({ top: 15, bottom: 15 })
            .width('90%')

          Column({ space: 10 }) {
            Row({ space: 8 }) {
              Circle().width(12).height(12).fill(Color.Green)
              Text(`No visa required : ${this.country.noVisaCountries}`)
                .fontSize(14)
                .fontColor(Color.White)
            }

            Row({ space: 8 }) {
              Circle().width(12).height(12).fill(Color.Red)
              Text(`Visa required : ${this.country.visaCountries}`)
                .fontSize(14)
                .fontColor(Color.White)
            }

            Row({ space: 8 }) {
              Circle().width(12).height(12).fill(Color.Yellow)
              Text(`E-Visa required : ${this.country.eVisaCountries}`)
                .fontSize(14)
                .fontColor(Color.White)
            }
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 20 })

          if (this.country.note) {
            Column({ space: 8 }) {
              Text('Information')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)

              Text(this.country.note)
                .fontSize(13)
                .fontColor('#CCCCCC')
                .lineHeight(18)
            }
            .margin({ top: 20 })
            .padding(15)
            .backgroundColor('#33FFFFFF')
            .borderRadius(10)
            .width('90%')
            .alignItems(HorizontalAlign.Start)
          }
        }
        .width('100%')
        .padding(16)
      }
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
      const ids: number[] | undefined = this.pathStack.getIndexByName('VisaDetailPage');
      if (Array.isArray(ids) && ids.length > 0) {
        const idx = ids[ids.length - 1];
        let paramObject = this.pathStack.getParamByIndex(idx) as CountryVisaInfo;
        if (paramObject) {
          this.country = paramObject
        }
      }
    })
    .width('100%')
    .height('100%')
    .hideTitleBar(true)
  }
}
