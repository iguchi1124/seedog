module Seedog
  class Configuration
    attr_accessor :file, :validate

    def initialize
      @file = Rails.root.join('db', 'Seedfile')
      @validate = false
    end
  end
end
