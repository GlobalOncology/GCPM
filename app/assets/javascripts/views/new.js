(function(App) {

  'use strict';

  App.View = App.View || {};
  App.View.AddNewProject = Backbone.View.extend({

      el: '.project_add',

    pickadateOptions: {
      today: false,
      clear: false,
      close: false,
      closeOnClear: false,
      closeOnSelect: false,
      selectYears: true,
      selectMonths: true,
      editable: false,
      format: 'yyyy-mm-dd',

      klass: {
        picker: 'picker-custom',
        holder: 'picker-holder-custom',
      },
      onStart: function() {
        this.$root.find( 'button, select' ).attr( 'disabled', false );
      },
      onRender: function() {
        this.$root.find( 'button, select' ).attr( 'disabled', false );
      },
      onOpen: function() {
        this.$root.find( 'button, select' ).attr( 'disabled', false );
      },
      onClose: function() {
        this.$root.find( 'button, select' ).attr( 'disabled', false );
      },
      onStop: function() {
        this.$root.find( 'button, select' ).attr( 'disabled', false );
      },
      onSet: function(context) {
        this.$root.find( 'button, select' ).attr( 'disabled', false );
      }
    },

    events: {
      'click .-editable' : 'displaInputs',
      'click .lead-investigator' : 'selectLead',
      'click .f-submit' : 'onSubmit'
    },

    initialize: function() {
      // Initialize Parent
      this.constructor.__super__.initialize.apply(this);
      // Inits
      this.render();
    },

    render: function() {
      this.renderChosen();
      this.renderPickADate();
      window.setTimeout(function(){
        $('.triggerAllNew').trigger('click').hide().parent().find('select.chosen-select').chosen({
          width: '100%',
          allow_single_deselect: true,
          inherit_select_classes: true,
          no_results_text: "Oops, nothing found!"
        });
      },500);
      return this;
    },

    renderChosen: function() {
      this.$el.find('.chosen-select').chosen({
        width: '100%',
        allow_single_deselect: true,
        inherit_select_classes: true,
        no_results_text: "Oops, nothing found!"
      });
    },
    
    displaInputs: function() {
      $('body').addClass('f-edited');
    },

    selectLead: function(ev) {
      $('.lead-investigator').prop('checked',false);
      $(ev.target).prop('checked',true);
    },

    onSubmit: function() {
      if (! !!$('#project_memberships_attributes_undefined_research_unit_id').val()) {
        $('.c-pregenerated').last().remove();
      }
    },

    displaInputs: function() {
      $('body').addClass('f-edited');
    },

    renderPickADate: function() {
      var $start = this.$el.find('#add-project-start_date').pickadate(_.extend({}, this.pickadateOptions, {
        container: '#pickadate-start-container'
      }));

      var $end = this.$el.find('#add-project-end_date').pickadate(_.extend({}, this.pickadateOptions, {
        container: '#pickadate-end-container'
      }));

    }
  });

})(this.App);