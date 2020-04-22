class PortfolioTitleUploader < BaseUploader

  create_sizes(
      sizes: {
        "1x" => [1366, 768],
        "2x" => [2732, 1536],
        "3x" => [4098, 2304]
      },
      namespace: "bg"
  )

end
