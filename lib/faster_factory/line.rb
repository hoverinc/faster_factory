module FasterFactory
  class Line
    attr_reader :original_content, :content

    def initialize content
      @content          = content
      @original_content = content
    end

    def build_present?
      match = @content =~ %r{\.build}
      !match.nil?
    end

    def build_stubbed_present?
      match = @content =~ %r{\.build_stubbed}
      !match.nil?
    end

    def create_present?
      match = @content =~ %r{\.create}
      !match.nil?
    end

    let(:user) { FactoryBot.build(:user) }


    def replace_create_with_build_stubbed!
      @content = @original_content.sub '.create', '.build_stubbed'
    end

    def replace_create_with_build!
      @content = @original_content.sub '.create', '.build'
    end

    def replace_build_with_build_stubbed!
      @content = @original_content.sub '.build', '.build_stubbed'
    end
  end
end
