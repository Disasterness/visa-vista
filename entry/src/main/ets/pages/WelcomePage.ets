@Entry
@Component
struct WelcomePage {

  pathStack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pathStack){
      Column() {
        Text('VisaVista')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 10 })
          .align(Alignment.Center)

        Text('Know Where You Stand')
          .fontSize(10)
          .fontColor(Color.Gray)
          .fontStyle(FontStyle.Italic)
          .margin({ top: 1, bottom: 20 })
          .align(Alignment.Center)

        Image($r('app.media.passportImage'))
          .width(85)
          .height(85)
          .onClick(() => {
            this.pathStack.pushPathByName('VisaPage', null)
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
    .hideBackButton(true)
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }
}
