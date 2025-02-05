require 'test_helper'

module CLI
  module Kit
    class IniTest < Minitest::Test
      def test_with_section_directives
        helper = Ini.new(fixture_path('ini_with_heading.conf'))
        assert_equal(
          { '[global]' => { 'key' => 'val', 'key2' => 'val2=' } },
          helper.parse
        )
      end

      def test_with_config_string
        helper = Ini.new(config: "[global]\nkey=val\nkey2=val2")
        assert_equal(
          { '[global]' => { 'key' => 'val', 'key2' => 'val2' } },
          helper.parse
        )
      end

      def test_without_section_directives
        helper = Ini.new(fixture_path('ini_without_heading.conf'))
        assert_equal(
          { '[global]' => { 'key' => 'val', 'key2' => 'val2=' } },
          helper.parse
        )
      end

      def test_with_and_without_section_directives
        helper = Ini.new(fixture_path('ini_with_and_without_heading.conf'))
        assert_equal({ '[global]' => { 'key' => 'val', 'key2' => 'val2=', 'key3' => 'val3' } }, helper.parse)
      end

      def test_with_no_existingpath
        helper = Ini.new('/not/a/path')
        assert_equal(
          {},
          helper.parse
        )
      end

      private

      def fixture_path(p)
        File.expand_path("../../../fixtures/#{p}", __FILE__)
      end
    end
  end
end
