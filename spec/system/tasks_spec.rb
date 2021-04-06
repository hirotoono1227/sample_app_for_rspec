require 'rails_helper'

RSpec.describe "Task", type: :system do
  let(:user) {create(:user)}
  let(:other_user) {create(:user)}
  let(:task) {create(:task)}
  let(:other_user_task) {create(:task)}
  describe "Task CRUD" do
    context "ログイン前" do
      it "タスクの新規作成ができないこと" do
        visit new_task_path
        expect(current_path).to eq login_path
        expect(page).to have_content 'Login required'
      end
      it "タスクの編集ができないこと" do
        visit edit_task_path(task)
        expect(current_path).to eq login_path
        expect(page).to have_content 'Login required'
      end
    end
    context "ログイン後" do
      before { sign_in_as(user) }
      it "タスクの新規作成ができること" do
        visit new_task_path
        fill_in 'Title', with: 'test_title'
        fill_in 'Content', with: 'test_content'
        select 'todo', from: 'Status'
        click_button 'Create Task'
        expect(current_path).to eq task_path(user)
        expect(page).to have_content 'Task was successfully created.'
      end
      it "タスクの編集ができること" do
        visit new_task_path
        fill_in 'Title', with: 'test_title'
        select 'todo', from: 'Status'
        click_button 'Create Task'
        click_on 'Edit'
        fill_in 'Title', with: 'changed_test_title'
        fill_in 'Content', with: 'changed_test_content'
        select 'todo', from: 'Status'
        click_button 'Update Task'
        expect(current_path).to eq task_path(user)
        expect(page).to have_content 'Task was successfully updated.'
      end
      it "タスクの削除ができること" do
        visit new_task_path
        fill_in 'Title', with: 'test_title'
        select 'todo', from: 'Status'
        click_button 'Create Task'
        click_on 'Back'
        click_on 'Destroy'
        page.accept_confirm
        expect(current_path).to eq tasks_path
        expect(page).to have_content 'Task was successfully destroyed.'
      end
      it "他ユーザーの編集ページへのアクセスが失敗すること" do
        visit edit_task_path(other_user_task)
        expect(page).to have_content 'Forbidden access.'
      end
    end

    describe 'マイページ' do
      before { sign_in_as(user) }
      context 'タスクを作成' do
        before do
          visit new_task_path
        fill_in 'Title', with: 'test_title'
        select 'todo', from: 'Status'
        click_button 'Create Task'
        end
        it '新規作成したタスクが表示される' do
          visit tasks_path(task)
          expect(page).to have_content 'test_title'
        end
      end
    end
  end
end
