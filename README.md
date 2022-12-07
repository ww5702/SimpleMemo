# SimpleMemo

***
2022.11.25   
Targets -> Singing   
우리가 만든 앱을 디바이스에서 실행하거나 다운받을 때 등록받지 않은 개발자나 해로운 앱들을 걸러준다.   
   
가장 많이 사용하는 NavigationUI를 사용   

앱 아이콘 메이커 : https://appicon.co/   
   
테이블 뷰 구현 이론   
iOS에서 가장 많이 사용하는 패턴이 delegate 패턴   
1. 테이블 뷰 배치   
2. 프로토타입 셀 디자인, 셀 identifier 지정   
3. Data source,  delegate 연결   
4. Data source 구현   
5. Delegate 구현   
 
Delegate는 셀을 선택했을 때 넘어가는 값들   
즉 셀을 선택할 필요가 없는 앱이라면 구현할 필요가 없다는것.   

***
2022.11.29   
Alert view   
간단한 정보를 표시하거나 두가지 옵션중 하나를 선택 할 때   
Action Sheet   
화면 아래쪽에 표시됨, 3가지 이상의 옵션중 하나를 선택 할 때   
   
viewWillAppear   
말 그대로 viewcontroller가 실행도기 직전에 실행되는 코드   
   
Var window: UIWindow?   
이전 버전의 ios에 작동하도록 구현   
   
Notification 에 관하여   
   
iOS에서 db를 사용할때는 Core Data를 사용    
 
