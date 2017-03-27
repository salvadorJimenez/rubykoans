require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutIteration < Neo::Koan

  # -- An Aside ------------------------------------------------------
  # Ruby 1.8 stores names as strings. Ruby 1.9 and later stores names
  # as symbols. So we use a version dependent method "as_name" to
  # convert to the right format in the koans. We will use "as_name"
  # whenever comparing to lists of methods.

  in_ruby_version("1.8") do
    def as_name(name)
      name.to_s
    end
  end

  in_ruby_version("1.9", "2") do
    def as_name(name)
      name.to_sym
    end
  end

  # Ok, now back to the Koans.
  # -------------------------------------------------------------------

  def test_each_is_a_method_on_arrays
    assert_equal true, [].methods.include?(as_name(:each))
  end

  def test_iterating_with_each
    array = [1, 2, 3]
    sum = 0
    array.each do |item|
      sum += item
    end
    assert_equal 6, sum
  end

  def test_each_can_use_curly_brace_blocks_too
    array = [1, 2, 3]
    sum = 0
    array.each { |item| sum += item }
    assert_equal 6, sum
  end

  def test_break_works_with_each_style_iterations
    array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    sum = 0
    array.each do |item|
      break if item > 3
      sum += item
    end
    assert_equal 6, sum
  end

  def test_collect_transforms_elements_of_an_array
    array = [1, 2, 3]
    new_array = array.collect { |item| item + 10 }
    assert_equal [11,12,13], new_array

    # NOTE: 'map' is another name for the 'collect' operation
    another_array = array.map { |item| item + 10 }
    assert_equal [11,12,13], another_array
  end

  def test_select_selects_certain_items_from_an_array
    array = [1, 2, 3, 4, 5, 6]

    even_numbers = array.select { |item| (item % 2) == 0 }
    assert_equal [2,4,6], even_numbers

    # NOTE: 'find_all' is another name for the 'select' operation
    more_even_numbers = array.find_all { |item| (item % 2) == 0 }
    assert_equal [2,4,6], more_even_numbers
  end

  def test_find_locates_the_first_element_matching_a_criteria
    array = ["Jim", "Bill", "Clarence", "Doug", "Eli"]

    assert_equal "Clarence", array.find { |item| item.size > 4 }
  end

  def test_inject_will_blow_your_mind
    result = [2, 3, 4].inject(0) { |sum, item| sum + item }
    assert_equal 9, result

    result2 = [2, 3, 4].inject(1) { |product, item| product * item }
    assert_equal 24, result2

    # Extra Credit:
    # Describe in your own words what inject does.
    # --------------------------------------------------------------
    # Description (Salvador Jiménez Mendoza)
    # It's a fact that i can't understand at all
    # In the result one seems like the inject(0) always have to use a sum and item 
    # and do the specific operation that in this case is sum+item.
    # In the second one seems like the inject(1) always have to use a product and item 
    # and do the specific operation that in this case is sum*item.
    # In both cases this iterate each element and use it for the operation 
    # ---------------------------------------------------------------
  end

  def test_all_iteration_methods_work_on_any_collection_not_just_arrays
    # Ranges act like a collection
    result = (1..3).map { |item| item + 10 }
    assert_equal [11,12,13], result

    # Files act like a collection of lines
    File.open("example_file.txt") do |file|
      upcase_lines = file.map { |line| line.strip.upcase }
      assert_equal ["THIS", "IS", "A", "TEST"], upcase_lines
    end

    # NOTE: You can create your own collections that work with each,
    # map, select, etc.
  end

  # Bonus Question:  In the previous koan, we saw the construct:
  #
  #   File.open(filename) do |file|
  #     # code to read 'file'
  #   end
  #
  # Why did we do it that way instead of the following?
  #
  #   file = File.open(filename)
  #   # code to read 'file'
  #   ------------------------------------------------------------
  #   Answer : (Salvador Jiménez Mendoza)
  #   You can do it in both cases and will work , the only difference
  #   maybe is that in this case you store the file in a variable and if you need it later 
  #   you only have to use it and thats it. When you use a block of code that is the case of this koan,
  #   you do the things at the moment and the File is not storaged in none variable
  #   if you want to use it have to repeat the procces. 
  #   -----------------------------------------------------------
  # When you get to the "AboutSandwichCode" koan, recheck your answer.

end
