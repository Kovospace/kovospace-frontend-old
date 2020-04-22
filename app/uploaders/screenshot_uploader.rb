## obrazok v zozname tvorby

class ScreenshotUploader < BaseUploader

  create_sizes(
      sizes: {
        "1x" => [360, 360],
        "2x" => [720, 720],
        "3x" => [1080, 1080],
        "small_1x" => [304, 304],
        "small_2x" => [608, 608],
        "small_3x" => [912, 912],
        "med_1x" => [320, 320],
        "med_2x" => [640, 640],
        "med_3x" => [960, 960]
      },
      namespace: "avatar"
  )

end
