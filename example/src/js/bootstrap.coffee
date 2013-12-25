# Require.js config
require
  urlArgs: "b=#{(new Date()).getTime()}"
  paths:
    hyper: 'vendor/hyper/hyper'
    React: 'vendor/react/react-with-addons'
  , ['app/main'], (main) -> main()