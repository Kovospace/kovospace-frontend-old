class PortfolioTitleUploader < BaseUploader

    create_sizes(
      sizes: {
        "1x" => [768, 10000],
        "2x" => [1536, 10000],
        "3x" => [2304, 10000]
      },
      namespace: "title_bg_desktop"
    )

end
