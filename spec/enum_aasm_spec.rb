#
# Copyright 2014 Arthur Shagall
#
require 'spec_helper'

class SpecModel
  # Class methods
  class << self
    def aasm_column
      :status
    end

    def transaction(args)
      yield
    end

    [:before_validation, :before_create, :validate].each do |method|
      module_eval( <<-end_eval, __FILE__, __LINE__ )
def #{method}(*args)
  true
end
      end_eval
    end
  end


  include AASM
  include AASM::Persistence::ActiveRecordPersistence

  attr_accessor :status

  def initialize
    self.status = :foo
  end

  aasm :column => :status do

    state :foo, :initial => true
    state :bar
    state :baz

    event :start do
      transitions :from => :foo, :to => :bar, :guard => :can_start?
      transitions :from => :foo, :to => :baz
    end

  end

  def can_start?
    true
  end

  def save
    true
  end

  def new_record?
    true
  end
end

describe "EnumAasm" do

  let(:model) { SpecModel.new }

  it 'basic transition' do
    model.start!.should be_true

    model.status.should eq(:bar)
  end

  it 'transition with guard' do
    model.should_receive(:can_start?).and_return(false)

    model.start!.should be_true

    model.status.should eq(:baz)
  end

  it 'if save fails' do
    model.should_receive(:save).and_return(false)

    model.start!.should be_false

    model.status.should eq(:foo)
  end

  it 'without saving' do
    model.start.should be_true

    model.status.should eq(:bar)
  end

  it 'invalid transition' do
    model.status = :baz

    expect {
      model.start.should be_false
    }.to raise_error(AASM::InvalidTransition)
  end
end
