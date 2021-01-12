require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      before do
        @task = Task.create!(name: 'test1', content: 'test2')
      end
      it '作成したタスクが表示される' do
        visit root_path(@task)
        expect(page).to have_content "test1"
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      before do
        @task = Task.create!(name: 'test1', content: 'test2')
       visit root_path
      end
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content "test1"
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       before do
         @task = Task.create!(name: 'test1', content: 'test2')
         visit task_path(@task)
       end
       it '該当タスクの内容が表示される' do
         expect(page).to have_content "test1"
       end
     end
  end
end
