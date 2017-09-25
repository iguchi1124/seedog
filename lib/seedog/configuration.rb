module Seedog
  class Configuration
    attr_accessor :file
    def initialize
      @file = Rails.root.join('db', 'Seedfile')
    end
  end
end
