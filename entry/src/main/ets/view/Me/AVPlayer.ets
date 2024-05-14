import media from '@ohos.multimedia.media'

export default class AVPlayer {
  static play: media.AVPlayer = {} as media.AVPlayer

  static async inint() {
    //空的
    AVPlayer.play = await media.createAVPlayer()
    AVPlayer.play.on('stateChange', (state) => {
      switch (state) {
        case 'initialized':
          AVPlayer.play.prepare()
          break
        case 'prepared':
          AVPlayer.play.play()
          break
      }
    })
  }
}