require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    context 'タスクが終了期限の降順に並んでいる場合' do

      before do
        user = FactoryBot.create(:user)

        task1 = FactoryBot.create(:task,name: 'test1',content: 'test1',deadline: "2021-01-01T15:15",user_id: user.id)
        task2 = FactoryBot.create(:task,name: 'test2',content: 'test2',deadline: "2021-01-01T15:15",user_id: user.id)

        label1 = FactoryBot.create(:label,name:'pokemon2')
        label2 = FactoryBot.create(:label,name:'pokemon3')

        FactoryBot.create(:task_label, task:task1, label:label1)
        FactoryBot.create(:task_label, task:task2, label:label2)

        visit '/sessions/new'
        fill_in 'Email', with: 'test1@outlook.jp'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
      end

      it 'タスクに複数のラベルをつけられる' do
        visit root_path
        expect(Task.first.labels[0][:name]).to have_content('pokemon')
        expect(Task.first.labels[1][:name]).to have_content('pokemon2')
      end

      it 'ラベルは、タスクを新規登録するときに（またはタスクの編集をするときに）タスクと一緒に登録（または編集）できる' do
        visit root_path
        expect(Task.first.labels[0][:name]).to have_content('pokemon')
        expect(Task.first.labels[1][:name]).to have_content('pokemon2')
      end

      it 'つけたラベルで検索ができる' do
        visit root_path
        select 'pokemon3', from: 'label_id'
        find_by_id('label_id').click
        find(:xpath, '/html[1]/body[1]/header[@class="container"]/div[@class="row"]/form[2]/input[2]').click
        task_list = all(".task_label")
        expect(task_list[0]).to have_content 'pokemon3'
      end
    end
  end
end
