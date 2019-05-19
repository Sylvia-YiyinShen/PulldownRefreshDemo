# PulldownRefreshDemo

* Easy to configure refresh control on existing tableView/collectionView
* Easy to replace the indicator(1-line change if using the indicator provided within the demo) https://github.com/Sylvia-YiyinShen/LoadingIndicatorDemo

## How to use
* Grab Indicator and PulldownRefresh folder with Assets to your project
* Make your tableView subclassing RefreshableTableView
* Invoke RefreshableTableView func configureRefreshControl(refreshHandler: @escaping () -> Void)
* Invoke in the right place RefreshableTableView  func refreshDone()


![01](https://user-images.githubusercontent.com/46996132/57981094-8bb2ef00-7a76-11e9-8ec6-6355ffa63402.gif)
![May-19-2019 20-41-30](https://user-images.githubusercontent.com/46996132/57981100-9077a300-7a76-11e9-9220-a011f9768b70.gif)
![02](https://user-images.githubusercontent.com/46996132/57981095-8c4b8580-7a76-11e9-9322-7d684e302b0f.gif)
![03](https://user-images.githubusercontent.com/46996132/57981096-8d7cb280-7a76-11e9-8b42-24151d02ed8a.gif)
