import { CountryVisaInfo } from '../model/CountryVisaInfo'
import { JSON } from '@kit.ArkTS'

@Entry
@Component
struct ComparisonPage {
  @State selectedCountries: CountryVisaInfo[] = [
    new CountryVisaInfo('United States', 7, 187, 4, 10, 'united_states'),
    new CountryVisaInfo('Turkey', 54, 110, 55, 28, 'turkey')
  ]

  aboutToAppear() {
    const params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params && params['selectedCountries']) {
      try {
        const parsedCountries = JSON.parse(params['selectedCountries'] as string) as CountryVisaInfo[]
        this.selectedCountries = parsedCountries
        console.error('JSON parsed:', this.selectedCountries)
      }
      catch (error) {
        console.error('JSON parse error:', error)
      }
    }
  }

  build() {
    Column() {
      Image($r('app.media.back_arrow'))
        .width(24)
        .height(24)
        .onClick(() => {
          this.getUIContext().getRouter().back()
        })
        .padding({ bottom: 10 })

      Row()
      {
        Column({space : 3})
        {
          Image($r(`app.media.${this.selectedCountries[0].mediaName}`))
            .width(20)
            .height(20)
            .objectFit(ImageFit.Fill)

          Text(this.selectedCountries[0].countryName)
            .fontSize(13)
            .align(Alignment.Center)
        }
        .alignItems(HorizontalAlign.Center)

        Blank()

        Column({space : 3})
        {
          Image($r(`app.media.${this.selectedCountries[1].mediaName}`))
            .width(20)
            .height(20)
            .objectFit(ImageFit.Fill)

          Text(this.selectedCountries[1].countryName)
            .fontSize(13)
            .align(Alignment.Center)
        }
        .alignItems(HorizontalAlign.Center)

      }
      .justifyContent(FlexAlign.Center)
      .width('90%')

      Column()
        .width('90%')
        .height(1)
        .alignSelf(ItemAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#ff807f7f')

      Row() {
        Text(` Ranking : ${this.selectedCountries[0].passportRank.toString()} `)
          .fontSize(13)
          .align(Alignment.Center)

        Blank()

        Text(` Ranking : ${this.selectedCountries[1].passportRank.toString()} `)
          .fontSize(13)
          .align(Alignment.Center)
      }
      .justifyContent(FlexAlign.Center)
      .width('85%')

      Column()
        .width('90%')
        .height(1)
        .alignSelf(ItemAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#ff807f7f')

      Row() {
        Column({space : 4}) {
          Row({space: 8}) {
            Circle()
              .width(10)
              .height(10)
              .fill(Color.Green)

            Text(this.selectedCountries[0].noVisaCountries.toString())
              .fontSize(13)
          }

          Row({space: 8}) {
            Circle()
              .width(10)
              .height(10)
              .fill(Color.Red)

            Text(this.selectedCountries[0].visaCountries.toString())
              .fontSize(13)
          }

          Row({space: 8}) {
            Circle()
              .width(10)
              .height(10)
              .fill(Color.Yellow)

            Text(this.selectedCountries[0].eVisaCountries.toString())
              .fontSize(13)
          }
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Row()
          .height('50%')
          .width(1)
          .alignSelf(ItemAlign.Center)
          .alignItems(VerticalAlign.Center)
          .backgroundColor('#ff807f7f')

        Blank()

        Column({space : 4}) {
          Row({space: 8})  {
            Circle()
              .width(10)
              .height(10)
              .fill(Color.Green)

            Text(this.selectedCountries[1].noVisaCountries.toString())
              .fontSize(13)
          }

          Row({space: 8})  {
            Circle()
              .width(10)
              .height(10)
              .fill(Color.Red)

            Text(this.selectedCountries[1].visaCountries.toString())
              .fontSize(13)
          }

          Row({space: 8}) {
            Circle()
              .width(10)
              .height(10)
              .fill(Color.Yellow)

            Text(this.selectedCountries[1].eVisaCountries.toString())
              .fontSize(13)
          }
        }
        .alignItems(HorizontalAlign.Start)
      }
      .justifyContent(FlexAlign.Center)
      .width('90%')
    }
    .margin({left: 8})
    .padding(20)
    .align(Alignment.Center)
  }
}
