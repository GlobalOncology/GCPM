module.exports = {
  "rules": {
    "no-console": ["error", {
      "allow": ["warn", "error", "info"]
    }]
  },
  "env": {
    "es6": false,
    "browser": true,
    "jquery": true
  },
  "globals": {
  	"L": true,
  	"Backbone": true,
  	"_": true,
  	"App": true,
    "HandlebarsTemplates": true
  },
  "extends": "eslint:recommended"
};
