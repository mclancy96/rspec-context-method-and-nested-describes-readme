# RSpec: The context Method & Nested Describes - Organizing Your Specs Like a Pro

If your specs are starting to look like a pile of laundry—everything mixed together, hard to find what you need—this lesson is for you. Today, we’ll learn how to use `context` and nested `describe` blocks to organize your tests, make your intentions clear, and keep your sanity.

---

## Why Organize Specs?

Imagine a library where all the books are in one giant heap. Finding anything would be a nightmare! Organizing your specs with `context` and nested `describe` blocks is like putting books on shelves by genre, author, and topic. It makes your tests easier to read, maintain, and expand.

In real-world projects, as your codebase grows, well-organized specs make it much easier to find, update, and debug tests. Nesting helps you keep related tests together, so you can quickly see what’s covered and what’s missing. Think of it like folders within folders on your computer—each level of nesting helps you zoom in on a specific feature or scenario.

## The context Method: Setting the Scene

Use `context` to group examples that share a setup, state, or condition. It’s like saying, “In this situation, here’s what should happen.”

```ruby
# /spec/context_and_nested_spec.rb
RSpec.describe ProjectManager do
  let(:manager) { ProjectManager.new }
  let(:kitchen) { RemodelProject.new("Kitchen Remodel") }
  let(:bathroom) { RemodelProject.new("Bathroom Remodel") }

  describe "#add_project" do
    it "adds a project to the manager" do
      manager.add_project(kitchen)
      expect(manager.projects).to include(kitchen)
    end
  end

  describe "#find_by_status" do
    context "when no projects have started" do
      before do
        manager.add_project(kitchen)
        manager.add_project(bathroom)
      end

      it "finds all projects with status 'not started'" do
        expect(manager.find_by_status("not started")).to contain_exactly(kitchen, bathroom)
      end
    end

    context "when some projects are in progress" do
      before do
        manager.add_project(kitchen)
        manager.add_project(bathroom)
        kitchen.start
      end

      it "finds projects by status" do
        expect(manager.find_by_status("in progress")).to include(kitchen)
        expect(manager.find_by_status("not started")).to include(bathroom)
      end
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
# /spec/context_and_nested_spec.rb
RSpec.describe RemodelProject do
  let(:project) { RemodelProject.new("Basement Remodel") }

  describe "#start" do
    context "when the project has not started" do
      it "sets status to 'in progress' and phase to planning" do
        project.start
        expect(project.status).to eq("in progress")
        expect(project.current_phase).to eq("planning")
      end
    end
  end

  describe "#advance_phase" do
    context "when the project is in progress" do
      before { project.start }

      it "advances through phases in order" do
        expect(project.current_phase).to eq("planning")
        project.advance_phase
        expect(project.current_phase).to eq("demolition")
        project.advance_phase
        expect(project.current_phase).to eq("construction")
        project.advance_phase
        expect(project.current_phase).to eq("finishing")
      end

      it "marks project as completed after last phase" do
        4.times { project.advance_phase } # go through all phases
        expect(project.completed?).to be true
        expect(project.status).to eq("completed")
        expect(project.current_phase).to be_nil
      end
    end

    context "when the project is not in progress" do
      it "does nothing if not started" do
        expect { project.advance_phase }.not_to change { project.status }
      end
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

---

## Getting Hands-On: Student Instructions

This lesson repo is set up for you to get hands-on practice with RSpec's `context` and nested `describe` blocks using a real-world home remodeling domain (RemodelProject/ProjectManager).

**To get started:**

1. **Fork and Clone** this repository to your own GitHub account and local machine.
2. **Install dependencies:**

    ```sh
    bundle install
    ```

3. **Run the specs:**

    ```sh
    bin/rspec
    ```

4. **Explore the code:**

- The main domain code is in `lib/remodel_project.rb`.
- The robust example specs are in `spec/context_and_nested_spec.rb`.

5. **Implement the pending specs:**

- There are at least two pending specs marked with `pending` in `spec/context_and_nested_spec.rb`.
- Your task: Remove the `pending` line and implement the expectation so the spec passes.

6. **Experiment:**

   - Try adding your own examples using `context` and nested `describe` blocks.
   - Make the specs fail on purpose to see the error messages and learn from them.

All specs should pass except the pending ones. When you finish, all specs should be green!

---

## Resources

- [RSpec: context and describe](https://relishapp.com/rspec/rspec-core/v/3-10/docs/example-groups/context)
- [Better Specs: Structure](https://www.betterspecs.org/#context)
- [Ruby Guides: RSpec Structure](https://www.rubyguides.com/2018/07/rspec/)

*Next: You’ll learn about subjects—implicit, explicit, and how they can make your specs even cleaner!*
