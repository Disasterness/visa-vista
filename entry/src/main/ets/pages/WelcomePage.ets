// WelcomePage.ets
import { router } from '@kit.ArkUI';

@Entry
@Component
struct WelcomePage {

  build() {
    Column() {
      // Top Title
      Text('VisaVista')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 10 })
        .align(Alignment.Center)

      // Subtitle
      Text('Know Where You Stand')
        .fontSize(10)
        .fontColor(Color.Gray)
        .fontStyle(FontStyle.Italic)
        .margin({ top: 1, bottom: 20 })
        .align(Alignment.Center)

      // Center Image (Clickable)
      Image($r('app.media.passportImage'))
        .width(85)
        .height(85)
        .onClick(() => {
          router.pushUrl({ url: 'pages/VisaPage' })
          // Navigate to VisaPage
        })
        .align(Alignment.Center)

      Text('See Where Your Passport\nCan Take You')
        .fontSize(12)
        .fontColor(Color.Gray)
        .margin({ top: 10 })
        .align(Alignment.Center)

    }
    .width('100%')
    .height('100%')
    .align(Alignment.Center)
    .padding(20)
  }
}
