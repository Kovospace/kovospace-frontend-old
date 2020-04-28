class PortfolioTitleUploader < BaseUploader

    create_sizes(
      sizes: {
        "xl_1x" => [768, 10000],
        "xl_2x" => [1536, 10000],
        "xl_3x" => [2304, 10000],
        "l_1x" => [600, 10000],
        "l_2x" => [1200, 10000],
        "l_3x" => [1800, 10000],
        "m_1x" => [360, 10000],
        "m_2x" => [720, 10000],
        "m_3x" => [1080, 10000],
        "s_1x" => [320, 10000],
        "s_2x" => [640, 10000],
        "s_3x" => [960, 10000],
        "xs_1x" => [240, 10000],
        "xs_2x" => [480, 10000],
        #"xs_3x" => [720, 10000], - opakovacka m_2x
      },
      namespace: "title_bg_desktop"
    )

end
