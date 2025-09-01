
require 'remodel_project'

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

  describe "edge cases" do
    context "when advancing phase after completion" do
      it "remains completed and does not error" do
        project.start
        4.times { project.advance_phase }
        expect(project.completed?).to be true
        expect { project.advance_phase }.not_to raise_error
        expect(project.status).to eq("completed")
      end
    end
  end

  describe "pending specs for students" do
    it "is pending: test that a new project has status 'not started' and no current phase" do
      pending("Student: Write a spec for initial project state")
      raise "Unimplemented pending spec"
    end

    it "is pending: test that advancing phase before starting does not change phase" do
      pending("Student: Write a spec for advancing phase before start")
      raise "Unimplemented pending spec"
    end
  end
end
