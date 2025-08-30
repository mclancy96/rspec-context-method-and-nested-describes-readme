# RSpec: The context Method & Nested Describes - Organizing Your Specs Like a Pro

Welcome to Lesson 9! If your specs are starting to look like a pile of laundry—everything mixed together, hard to find what you need—this lesson is for you. Today, we’ll learn how to use `context` and nested `describe` blocks to organize your tests, make your intentions clear, and keep your sanity.

---

## Why Organize Specs?

Imagine a library where all the books are in one giant heap. Finding anything would be a nightmare! Organizing your specs with `context` and nested `describe` blocks is like putting books on shelves by genre, author, and topic. It makes your tests easier to read, maintain, and expand.

In real-world projects, as your codebase grows, well-organized specs make it much easier to find, update, and debug tests. Nesting helps you keep related tests together, so you can quickly see what’s covered and what’s missing. Think of it like folders within folders on your computer—each level of nesting helps you zoom in on a specific feature or scenario.

## The context Method: Setting the Scene

Use `context` to group examples that share a setup, state, or condition. It’s like saying, “In this situation, here’s what should happen.”

```ruby
# /spec/string_manipulator_spec.rb
RSpec.describe StringManipulator do
  context "when reversing a string" do
    it "returns the reversed string" do
      expect(StringManipulator.new.reverse("abc")).to eq("cba")
    end
  end

  context "when upcasing a string" do
    it "returns the string in uppercase" do
      expect(StringManipulator.new.upcase("abc")).to eq("ABC")
    end
  end

  context "when given an empty string" do
    it "returns an empty string when reversed" do
      expect(StringManipulator.new.reverse("")).to eq("")
    end
    it "returns an empty string when upcased" do
      expect(StringManipulator.new.upcase("")).to eq("")
    end
  end
end
```

When you run these specs, you’ll see output like:

```zsh
StringManipulator
  when reversing a string
    returns the reversed string
  when upcasing a string
    returns the string in uppercase
  when given an empty string
    returns an empty string when reversed
    returns an empty string when upcased

Finished in 0.01 seconds (files took 0.1 seconds to load)
4 examples, 0 failures
```

Notice how the output mirrors your `describe` and `context` structure, making it easy to see what’s being tested and where things might go wrong.

## Nested Describes: Zooming In

Use nested `describe` blocks to break down your specs even further. This is great for testing different methods, edge cases, or behaviors within a class.

```ruby
# /spec/calculator_spec.rb
RSpec.describe Calculator do
  describe "#add" do
    context "with positive numbers" do
      it "returns the sum" do
        expect(Calculator.new.add(2, 3)).to eq(5)
      end
    end

    context "with negative numbers" do
      it "returns the sum" do
        expect(Calculator.new.add(-2, -3)).to eq(-5)
      end
    end

    context "with zero" do
      it "returns the other number" do
        expect(Calculator.new.add(0, 5)).to eq(5)
      end
    end
  end

  describe "#subtract" do
    it "returns the difference" do
      expect(Calculator.new.subtract(5, 2)).to eq(3)
    end
  end
end
```

Running these specs gives you output like:

```shell
Calculator
  #add
    with positive numbers
      returns the sum
    with negative numbers
      returns the sum
    with zero
      returns the other number
  #subtract
    returns the difference

Finished in 0.01 seconds (files took 0.1 seconds to load)
4 examples, 0 failures
```

Each level of nesting in your spec file shows up as indentation in the output, making it easy to trace exactly which scenario is being tested.

Here’s a simple diagram to help you visualize the structure:

```zsh
describe "Calculator"
  └── describe "#add"
    ├── context "with positive numbers"
    │     └── it "returns the sum"
    ├── context "with negative numbers"
    │     └── it "returns the sum"
    └── context "with zero"
      └── it "returns the other number"
  └── describe "#subtract"
    └── it "returns the difference"
```

## Tips for Organizing Specs

- Use `context` for different situations, states, or branches of logic (e.g., valid/invalid input, edge cases, error conditions).
- Use nested `describe` for different methods or features.
- Write descriptions in plain English—future you (and your teammates) will thank you! The text you use in `describe` and `context` appears in RSpec’s output, so make it human-readable and descriptive.
- Don’t be afraid to nest blocks, but keep things readable.

## Practice Prompts

Try these exercises to reinforce your learning. For each, write your own spec in the appropriate file (e.g., `/spec/calculator_spec.rb`).

**Exercise 1: Use context for scenarios**
Refactor a spec to use `context` blocks for different scenarios (e.g., valid vs invalid input, edge cases like empty strings or nil values).

**Exercise 2: Add nested describe blocks**
Add nested `describe` blocks for each method in a class. How does it change the readability?

**Exercise 3: Multi-level nesting**
Write a spec with at least two levels of nesting. Try including a branch for an edge case (e.g., zero, nil, or an error condition). What are the benefits and drawbacks?

**Exercise 4: Naming and organization reflection**
Why is clear organization and descriptive naming important in testing? Write your answer in your own words.

---

## Resources

- [RSpec: context and describe](https://relishapp.com/rspec/rspec-core/v/3-10/docs/example-groups/context)
- [Better Specs: Structure](https://www.betterspecs.org/#context)
- [Ruby Guides: RSpec Structure](https://www.rubyguides.com/2018/07/rspec/)

*Next: You’ll learn about subjects—implicit, explicit, and how they can make your specs even cleaner!*
