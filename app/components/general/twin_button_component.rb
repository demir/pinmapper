# frozen_string_literal: true

module General
  class TwinButtonComponent < ViewComponent::Base
    include Turbo::FramesHelper
    attr_reader :first_button, :display, :method, :first_button_text, :record_dom_id,
                :first_button_class, :first_button_path, :second_button_mouseout_text,
                :second_button_mouseover_text, :second_button_path, :second_button_class

    def initialize(**arguments)
      args = default_arguments.merge(arguments)
      argument_assignments(args)
      @display = args[:display_block].call if args[:display_block].present?
    end

    def render?
      display
    end

    private

    # rubocop:disable Metrics/MethodLength
    def default_arguments
      {
        first_button:                 true,
        display:                      true,
        record_dom_id:                '',
        method:                       :get,
        first_button_text:            I18n.t('follow'),
        first_button_class:           'btn_1 rounded small outline',
        first_button_path:            '#',
        second_button_mouseout_text:  I18n.t('following'),
        second_button_mouseover_text: I18n.t('unfollow'),
        second_button_class:          'btn_1 rounded small',
        second_button_path:           '#'
      }
    end

    def argument_assignments(args)
      @first_button = args[:first_button]
      @display = args[:display]
      @record_dom_id = args[:record_dom_id]
      @method = args[:method]
      @first_button_text = args[:first_button_text]
      @first_button_class = args[:first_button_class]
      @first_button_path = args[:first_button_path]
      @second_button_mouseout_text = args[:second_button_mouseout_text]
      @second_button_mouseover_text = args[:second_button_mouseover_text]
      @second_button_class = args[:second_button_class]
      @second_button_path = args[:second_button_path]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
