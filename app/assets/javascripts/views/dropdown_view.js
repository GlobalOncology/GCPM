(function(App) {

  'use strict';

  App.View.Dropdown = Backbone.View.extend({

    defaults: {
      label: null,
      className: '',
      options: [],
      open: false
    },

    events: {
      'click .js-open': 'toggleDropdown',
      'click .js-option': 'selectOption'
    },

    template: HandlebarsTemplates['dropdown'],

    initialize: function(settings) {
      var opts = settings && settings.options;
      opts = opts || new Object();
      opts.className = [this.defaults.className, opts.className || ''].join(' ');
      this.options = _.extend({}, this.defaults, opts);

      this.render();
      this.setEvents();
    },

    render: function() {
      this.options.current = _.findWhere(this.options.options, {
        selected: true
      });
      this.$el.html(this.template(this.options));
      return this;
    },

    setEvents: function() {
      $(document).on('click', this.handleDocumentClick.bind(this));
    },

    /**
     * Render new options and render again
     * @param {Array} options
     * @example
     * [{ name: 'Title', value: 1 }]
     */
    setOptions: function(options) {
      this.options.options = options;
      this.render();
    },

    setState: function(state) {
      this.state.attributes = state;
    },

    selectOption: function(e) {
      var value = e.currentTarget.getAttribute('data-value');
      var name = e.currentTarget.getAttribute('name');

      // Set the selected
      this.$el.find('.dropdown-item').removeClass('-selected');
      $(e.currentTarget).parent().addClass('-selected');

      // Set the selected name
      this.$el.find('.dropdown-value').html(name);
      this.trigger('change', { name: name, value: value });

      this.toggleDropdown();
    },

    handleDocumentClick: function(e) {
      var isContained = this.el.contains(e.target);
      !isContained && this.options.open && this.toggleDropdown();
    },

    toggleDropdown: function() {
      this.options.open = !this.options.open;
      this.$el.find('.dropdown-content').toggleClass('-open');
    }

  });

})(this.App);
