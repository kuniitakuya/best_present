module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],

  plugins: [
    require("daisyui")
  ],

   //daisyUIのテーマを設定
  daisyui: {
    themes: ["retro"],
  },

  daisyui: {
    themes: [
      {
        retro: {
          ...require("daisyui/src/colors/themes")["[data-theme=retro]"],
          "base-100": "#FBECC6",
          "accent-focus": "#F5D174",
        },
      },
    ],
  },
}