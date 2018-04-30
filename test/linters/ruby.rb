module Foo
  module Bar
    class Example
      LOC_TEST_ARRAY = [
        'this',
        'is',
        'just',
        'an',
        'array',
        'full',
        'of',
        'words',
        'in',
        'order',
        'for',
        'this',
        'file',
        'to',
        'surpass',
        'the',
        '150',
        'lines',
        'of',
        'code',
        'this',
        'is',
        'still',
        'not',
        'enough',
        'so',
        'we',
        'need',
        'to',
        'adds',
        'some',
        'more',
        'values',
        'and',
        'now',
        'we',
        'are',
        'done'
      ].freeze

      def empty_method
      end

      def long_method
        first_method_call(
          foo: 'bar',
          bar: 'barian'
        )

        second_method_call(
          with: 'some',
          more: 'args',
          in: 'order',
          to: 'surpass',
          the: 'fifteen',
          lines: 'of code'
        )
      end

      def method_with_long_line
        this_is_a_very_long_line_of_code.map { |very_long_line_of_code| very_long_line_of_code.gsub('very', 'really') }
      end

      def alignment
        User
          .where(name: 'foobar')
          .joins(:badge)
          .group_by(:badge_count)
          .order_by(name: :asc)

        @user =
          User
            .where(name: 'foobar')
            .joins(:badge)
            .group_by(:badge_count)
            .order_by(name: :asc)
      end

      def variable_alignment
        @user =
          User
            .where(name: 'foobar')
            .joins(:badge)
      end

      def method_with_arrays
        i_prefer [:a, :normal, :list, :of, :symbols]
        i_prefer ['a', 'normal', 'list', 'of', 'words']
      end

      def has_something?
        false
      end

      def is_something?
        true
      end
    end
  end
end
