module Foo
  module Bar
    class Example
      def empty_method
      end

      def long_method
        method_call
        method_call_1
        method_call_2
        method_call_3
        method_call_4
        method_call_5
        method_call_6
        method_call_7
        method_call_8
        method_call_9
        method_call_10
        method_call_11
        method_call_12
        method_call_13
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
      end

      def variable_alignment
        user = # rubocop:disable UselessAssignment
          User
            .where(name: 'foobar')
            .joins(:badge)
      end

      def long_method_2
        method_call
        method_call_1
        method_call_2
        method_call_3
        method_call_4
        method_call_5
        method_call_6
        method_call_7
        method_call_8
        method_call_9
        method_call_10
        method_call_11
        method_call_12
        method_call_13
      end

      def long_method_3
        method_call
        method_call_1
        method_call_2
        method_call_3
        method_call_4
        method_call_5
        method_call_6
        method_call_7
        method_call_8
        method_call_9
        method_call_10
        method_call_11
        method_call_12
        method_call_13
      end

      def long_method_4
        method_call
        method_call_1
        method_call_2
        method_call_3
        method_call_4
        method_call_5
        method_call_6
        method_call_7
        method_call_8
        method_call_9
        method_call_10
        method_call_11
        method_call_12
        method_call_13
      end

      def long_method_5
        method_call
        method_call_1
        method_call_2
        method_call_3
        method_call_4
        method_call_5
        method_call_6
        method_call_7
        method_call_8
        method_call_9
        method_call_10
        method_call_11
        method_call_12
        method_call_13
      end

      def long_method_6
        method_call
        method_call_1
        method_call_2
        method_call_3
        method_call_4
        method_call_5
        method_call_6
        method_call_7
        method_call_8
        method_call_9
        method_call_10
        method_call_11
        method_call_12
        method_call_13
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
