# 開発時の設定等

## Brokerをホスト側で動作させたい場合の方法

EclipseでBrokerをデバッガーを使って実行させたい場合などで有効

1. src にある以下のファイルをEclipseにプロジェクトとしてインポート
    * MAGCruiseBroker/projects/MAGCruiseBroker
    * MAGCruiseBroker/projects/MAGCruiseWebUIStab
    * MAGCruiseLibraries

    MAGCruiseBrokerプロジェクトを選択し「サーバで実行」する

2. WebUIからEclipse上のBrokerへ通信を行えるよう設定を変更

    MAGCruiseWebUI/app/Config/const.php を開き、以下の定数をそれぞれ書き換える

    * CORE_FOR_DEV_URL

        => "/MAGCruiseBroker"
    * CORE_CONTROLLER_URL

        => "http://192.168.30.1/MAGCruiseBroker/jsServices/MAGCruiseCoreController"
    * PROCESS_CONTROLLER_URL

        => "http://192.168.30.1/MAGCruiseBroker/jsServices/ProcessController"

3. Eclipseで実行中のBrokerからWebUIへ通信を行えるよう設定を変更

    MAGCruiseCoreController.xml 内の コンテキストプロパティ webUIUrl を ```http://192.168.30.10/json``` に指定
