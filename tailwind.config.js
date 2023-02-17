module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],

  theme: {
    extend: {
      fontFamily: {
        sawarabi: ["Sawarabi Mincho"],
      },
    },
  },

  plugins: [
    require("daisyui")
  ],

   //daisyUIのテーマを設定
  daisyui: {
    themes: [
      {
        retro: {
          ...require("daisyui/src/colors/themes")["[data-theme=retro]"],
          "base-100": "#FBECC6",
          "accent-focus": "#F5D174",
          "info": "#1DA1F2",
          "info-content": "#FFFFFF",
          "success": "#06C755",
          "success-content": "#FFFFFF"
        },
      },
    ],
  },
}