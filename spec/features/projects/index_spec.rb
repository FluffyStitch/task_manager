# frozen_string_literal: true

RSpec.describe 'Projects > Index', type: :feature, js: true do
  let(:current_page) { ProjectIndex.new }
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  it 'exit' do
    current_page.load
    current_page.sign_out.click

    expect(current_page).to have_content I18n.t('devise.failure.unauthenticated')
  end

  describe 'add TODO list' do
    let(:project_name) { attributes_for(:project)[:name] }

    before do
      current_page.load
      current_page.add_project.click
      current_page.wait_until_project_modal_visible
      current_page.project_modal.project_name.fill_in(with: project_name)
      current_page.project_modal.submit.click
    end

    context 'when params is valid' do
      it 'success' do
        current_page.wait_until_projects_visible

        expect(current_page.first_project).to have_name(text: project_name)
      end
    end

    context 'when name is empty' do
      let(:project_name) { attributes_for(:project, name: '')[:name] }

      it 'failed' do
        current_page.wait_until_project_modal_visible

        expect(current_page.project_modal).to have_error(text: I18n.t('errors.messages.blank'))
      end
    end
  end

  describe 'edit project' do
    let(:project_name) { attributes_for(:project)[:name] }

    before do
      create(:project, user: user)
      current_page.load
      current_page.first_project.edit.click
      current_page.wait_until_project_modal_visible
      current_page.project_modal.project_name.fill_in(with: project_name)
      current_page.project_modal.submit.click
    end

    context 'when params is valid' do
      it 'success' do
        current_page.first_project.wait_until_name_visible

        expect(current_page.first_project).to have_name(text: project_name)
      end
    end

    context 'when name is empty' do
      let(:project_name) { attributes_for(:project, name: '')[:name] }

      it 'failed' do
        current_page.wait_until_project_modal_visible

        expect(current_page.project_modal).to have_error(text: I18n.t('errors.messages.blank'))
      end
    end
  end

  describe 'delete project' do
    before do
      create(:project, user: user)
      current_page.load
    end

    it 'success' do
      current_page.first_project.delete.click

      expect(current_page).to have_no_projects
    end
  end

  describe 'add task without deadline' do
    let!(:project) { create(:project, user: user) }
    let(:task_params) { attributes_for(:task, project: project) }

    before do
      current_page.load
      current_page.first_project.new_task.name.fill_in(with: task_params[:text])
      current_page.first_project.new_task.submit.click
    end

    context 'when param is valid' do
      it 'success' do
        current_page.first_project.wait_until_new_task_visible

        expect(current_page.first_task).to have_text(task_params[:text])
      end
    end

    context 'when text is empty' do
      let(:task_params) { attributes_for(:task, project: project, text: '') }

      it 'failed' do
        current_page.first_project.wait_until_new_task_visible

        expect(current_page.first_project.new_task).to have_error(text: I18n.t('errors.messages.blank'))
      end
    end
  end

  describe 'add task with deadline' do
    let!(:project) { create(:project, user: user) }
    let(:task_params) { attributes_for(:task, project: project) }

    before do
      current_page.load
      current_page.first_project.plus.click
      current_page.first_project.new_task.name.fill_in(with: task_params[:text])
      current_page.first_project.new_task.deadline.click
      current_page.flatpickr.next_month.click
      current_page.flatpickr.day.click
      current_page.first_project.new_task.submit.click
    end

    context 'when params is valid' do
      it 'has text' do
        expect(current_page.first_task).to have_text(task_params[:text])
      end

      it 'has deadline' do
        expect(current_page.first_task).to have_deadline(text: task_params[:deadline])
      end
    end

    context 'when text is empty' do
      let(:task_params) { attributes_for(:task, text: '', project: project) }

      it 'failed' do
        current_page.first_project.wait_until_new_task_visible

        expect(current_page.first_project.new_task).to have_error(text: I18n.t('errors.messages.blank'))
      end
    end
  end

  describe 'edit task' do
    let!(:project) { create(:project, user: user) }
    let(:task_text) { attributes_for(:task, project: project)[:text] }

    before do
      create(:task, project: project)
      current_page.load
      current_page.first_task.edit.click
      current_page.task_modal.task_text.fill_in(with: task_text)
      current_page.task_modal.submit.click
    end

    context 'when params is valid' do
      it 'success' do
        current_page.first_project.wait_until_tasks_visible

        expect(current_page.first_task).to have_text(task_text)
      end
    end

    context 'when text is empty' do
      let(:task_text) { attributes_for(:task, project: project, text: '')[:text] }

      it 'failed' do
        current_page.wait_until_task_modal_visible

        expect(current_page.task_modal).to have_error(text: I18n.t('errors.messages.blank'))
      end
    end
  end

  describe 'delete task' do
    let!(:project) { create(:project, user: user) }

    before do
      create(:task, project: project)
      current_page.load
    end

    it 'success' do
      current_page.first_task.delete.click

      expect(current_page.first_project).to have_no_tasks
    end
  end

  describe 'completed' do
    let!(:project) { create(:project, user: user) }

    context "when don't completed" do
      it 'check' do
        create(:task, project: project)
        current_page.load
        current_page.first_task.completed.check

        expect(current_page.first_task.completed).to be_checked
      end
    end

    context 'when completed' do
      it 'uncheck' do
        create(:task, project: project, completed: true)
        current_page.load
        current_page.first_task.completed.uncheck

        expect(current_page.first_task.completed).not_to be_checked
      end
    end
  end

  describe 'reprioritate' do
    let!(:project) { create(:project, user: user) }
    let!(:first_task) { create(:task, project: project) }
    let!(:second_task) { create(:task, project: project) }

    before do
      current_page.load
    end

    context 'when element moves up' do
      it 'first to first' do
        current_page.first_task.up.click
        current_page.first_project.wait_until_tasks_visible

        expect(current_page.first_task).to have_text(first_task.text)
      end

      it 'second to first' do
        current_page.second_task.up.click
        current_page.first_project.wait_until_tasks_visible

        expect(current_page.first_task).to have_text(second_task.text)
      end
    end

    context 'when element moves down' do
      it 'first to second' do
        current_page.first_task.down.click
        current_page.first_project.wait_until_tasks_visible

        expect(current_page.second_task).to have_text(first_task.text)
      end

      it 'last to last' do
        current_page.second_task.down.click
        current_page.first_project.wait_until_tasks_visible

        expect(current_page.second_task).to have_text(second_task.text)
      end
    end
  end
end
