import { CountryVisaInfo } from '../model/CountryVisaInfo'

@Builder
export function ComparisonPageBuilder() {
  ComparisonPage()
}

@Entry
@Component
struct ComparisonPage {
  pathStack: NavPathStack = new NavPathStack()
  @State selectedCountries: CountryVisaInfo[] = [
    new CountryVisaInfo('United States', 7, 187, 4, 10, 'united_states', ''),
    new CountryVisaInfo('Turkey', 54, 110, 55, 28, 'turkey', '')
  ]

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
          .padding({ bottom: 10 })

          Row() {
            Column({ space: 3 }) {
              Image($r(`app.media.${this.selectedCountries[0].mediaName}`))
                .width(20)
                .height(20)
                .objectFit(ImageFit.Fill)

              Text(this.selectedCountries[0].countryName)
                .fontSize(13)
                .fontColor(Color.White)
                .textAlign(TextAlign.Center)
            }
            .layoutWeight(1)

            Text('VS')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Gray)
              .margin({ left: 10, right: 10 })

            Column({ space: 3 }) {
              Image($r(`app.media.${this.selectedCountries[1].mediaName}`))
                .width(20)
                .height(20)
                .objectFit(ImageFit.Fill)

              Text(this.selectedCountries[1].countryName)
                .fontSize(13)
                .fontColor(Color.White)
                .textAlign(TextAlign.Center)
            }
            .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 10, right: 10 })

          Divider()
            .strokeWidth(1)
            .color('#ff807f7f')
            .margin({ top: 10, bottom: 10 })
            .width('90%')

          Row() {
            Text(`Ranking: ${this.selectedCountries[0].passportRank}`)
              .fontSize(13)
              .fontColor(Color.White)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)

            Text(`Ranking: ${this.selectedCountries[1].passportRank}`)
              .fontSize(13)
              .fontColor(Color.White)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)
          }
          .width('100%')

          Divider()
            .strokeWidth(1)
            .color('#ff807f7f')
            .margin({ top: 10, bottom: 10 })
            .width('90%')

          Row() {
            // Left country stats
            Column({ space: 8 }) {
              this.StatRow(Color.Green, this.selectedCountries[0].noVisaCountries.toString())
              this.StatRow(Color.Red, this.selectedCountries[0].visaCountries.toString())
              this.StatRow(Color.Yellow, this.selectedCountries[0].eVisaCountries.toString())
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 20 })

            Divider()
              .vertical(true)
              .height(60)
              .color('#ff807f7f')

            // Right country stats
            Column({ space: 8 }) {
              this.StatRow(Color.Green, this.selectedCountries[1].noVisaCountries.toString())
              this.StatRow(Color.Red, this.selectedCountries[1].visaCountries.toString())
              this.StatRow(Color.Yellow, this.selectedCountries[1].eVisaCountries.toString())
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 20 })
          }
          .width('100%')
          .margin({ bottom: 20 })

          if (this.selectedCountries[0].note || this.selectedCountries[1].note) {
            Column({ space: 10 }) {
              Text('Notes Comparison')
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .width('100%')

              if (this.selectedCountries[0].note) {
                this.NoteBox(this.selectedCountries[0].countryName, this.selectedCountries[0].note)
              }

              if (this.selectedCountries[1].note) {
                this.NoteBox(this.selectedCountries[1].countryName, this.selectedCountries[1].note)
              }
            }
            .padding(10)
            .width('100%')
          }
        }
        .width('100%')
        .padding(16)
      }
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
      // The original code used 'PlayerPage', which seemed like a copy-paste error.
      // It should probably be 'ComparisonPage'
      const ids: number[] | undefined = this.pathStack.getIndexByName('ComparisonPage');

      if (Array.isArray(ids) && ids.length > 0) {
        const idx = ids[ids.length - 1];
        const params = this.pathStack.getParamByIndex(idx) as Record<string, Object>;
        if (params && params.selectedCountries) {
          try {
            const parsedCountries = JSON.parse(params.selectedCountries as string) as CountryVisaInfo[]
            this.selectedCountries = parsedCountries
          } catch (error) {
            console.error('JSON parse error:', error)
          }
        }
      }
    })
    .width('100%')
    .height('100%')
    .hideTitleBar(true)
  }

  @Builder
  StatRow(color: ResourceColor, value: string) {
    Row({ space: 8 }) {
      Circle().width(10).height(10).fill(color)
      Text(value).fontSize(13).fontColor(Color.White)
    }
  }

  @Builder
  NoteBox(countryName: string, note: string) {
    Column({ space: 4 }) {
      Text(countryName)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
      Text(note)
        .fontSize(11)
        .fontColor('#CCCCCC')
    }
    .padding(8)
    .backgroundColor('#22FFFFFF')
    .borderRadius(8)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
