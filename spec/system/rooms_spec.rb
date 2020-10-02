require 'rails_helper'

RSpec.describe "チャットルームの削除機能", type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it 'チャットルームを削除すると、関連するメッセージがすべて削除されていること' do
    # サインインする
    sign_in(@room_user.user)

    # 作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)

    # メッセージ情報を5つDBに追加する
    FactoryBot.create_list(:message, 5, room_id: @room_user.room.id, user_id: @room_user.user.id)

=begin
    5.times do |message|
      message = FactoryBot.build(:message)
      fill_in "message_content", with: message
      expect{
        click_on("送信")
      }.to change { Message.count }.by(1)
    end
=end

    # 「チャットを終了する」ボタンをクリックすることで、作成した5つのメッセージが削除されていることを確認する
    expect{
      click_on("チャットを終了する")
    }.to change { Message.count }.by(-5) 
    # トップページに遷移していることを確認する
    expect(current_path).to eq root_path

  end
end