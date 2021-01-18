require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    context 'タスクが終了期限の降順に並んでいる場合' do
      before do
        Task.create!(name: 'test1',content: 'test1',deadline: "2021-01-01T15:15")
        Task.create!(name: 'test2', content: 'test2',deadline: "2021-01-31T15:15")
     end
      it '一覧画面で終了期限でソートするを押すと終了期限が遠いものが一番上に表示される' do
        visit root_path
        click_on '終了期限でソートする'
        task_list = all(".task_name")
        expect(task_list[0]).to have_content 'test2'
        expect(task_list[1]).to have_content 'test1'
      end
      context 'タスクを新規作成した場合、作成したタスクが表示される' do
       before do
          FactoryBot.create(:task,name: 'test1',content: 'test1',status: "未着手",priority: "中")
          FactoryBot.create(:task,name: 'test2', content: 'test2',status: "着手中",priority: "低")
          FactoryBot.create(:task,name: 'test3', content: 'test3',status: "完了",priority: "高")
       end
       
       it 'タイトルで検索できる' do
         visit root_path
         fill_in 'sarch', with: '2'
         find(:xpath, '/html[1]/body[1]/header[1]/form[1]/input[3]').click
         task_list = all(".task_name")

         expect(task_list[0]).to have_content 'test2'
       end

       it 'ステータスで検索できる' do
         visit root_path
         select '完了', from: 'status'
         find(:xpath, '/html[1]/body[1]/header[1]/form[1]/input[3]').click
         task_list = all(".task_name")

         expect(task_list[0]).to have_content 'test3'
       end

       it 'タイトルとステータスで検索できる' do
         visit root_path
         fill_in 'sarch', with: '3'
         select '完了', from: 'status'
         find(:xpath, '/html[1]/body[1]/header[1]/form[1]/input[3]').click
         task_list = all(".task_name")

         expect(task_list[0]).to have_content 'test3'
       end

       it '優先順位でソートする' do
         visit root_path
         click_link '優先順位でソートする'
         task_list = all(".task_name")
         expect(task_list[0]).to have_content 'test3'
         expect(task_list[1]).to have_content 'test1'
       end

      end
    end
  end

end
