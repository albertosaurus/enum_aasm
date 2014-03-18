#
# Copyright 2014 Arthur Shagall
#

require "enum_aasm/version"
require 'power_enum'
require 'aasm'
require 'aasm/base'
require 'aasm/persistence/active_record_persistence'
require 'aasm/persistence/base'

AASM::Persistence::ActiveRecordPersistence::InstanceMethods.module_eval do

  # Patched to use the enumerated attribute
  def aasm_write_state(state)
    attr_name = self.class.aasm_column
    old_value = self.__send__(attr_name)
    self.__send__("#{attr_name}=", state)

    success = if AASM::StateMachine[self.class].config.skip_validation_on_save
                self.update_attribute(attr_name, state)
              else
                self.save
              end
    if success
      true
    else
      self.__send__("#{attr_name}=", old_value)
      false
    end
  end

  # Patched to use the enumerated attribute
  def aasm_write_state_without_persistence(state)
    self.__send__("#{self.class.aasm_column}=", state)
  end

end

AASM::Base.module_eval do

  # Scopes need to be disabled. PowerEnum already provides this functionality
  def state(name, *args)
    state_without_scope(name, *args)
  end

end

AASM::Persistence::ActiveRecordPersistence.module_eval do

  def self.included(base)
    base.send(:include, AASM::Persistence::Base)
    base.send(:include, AASM::Persistence::ActiveRecordPersistence::InstanceMethods)

    base.before_validation(:aasm_ensure_initial_state, :on => :create)

    # ensure initial aasm state even when validations are skipped
    base.before_create(:aasm_ensure_initial_state)

    # ensure state is in the list of states
    base.validate :aasm_validate_states
  end

end
