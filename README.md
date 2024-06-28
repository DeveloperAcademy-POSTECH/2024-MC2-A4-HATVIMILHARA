# 2024-MC2-A4-HATVIMILHARA

<br>


# 도래(DORAE) 앱소개

![앱로고.png](Dorae%20%E1%84%80%E1%85%B5%E1%86%BA%E1%84%92%E1%85%A5%E1%84%87%E1%85%B3%20%E1%84%85%E1%85%B5%E1%84%83%E1%85%B3%E1%84%86%E1%85%B5%20f9a18c91a921478dbc7b4594faf9a790/%25E1%2584%258B%25E1%2585%25A2%25E1%2586%25B8%25E1%2584%2585%25E1%2585%25A9%25E1%2584%2580%25E1%2585%25A9.png)


> 글로 쓴 전통매듭 도안을 완성된 모습을 예상하기 쉽게
이미지 도안으로 보여주는 앱
> 

- 전통매듭공예는 취미로 즐기고 있는 사용자에게서 발견한 문제<br>→ ***매듭 도안을 글로만 작성하고 있어서 완성된 결과물을 예상하기 어렵고, 도안을 창작하기 어렵다!***
- 어떻게 해결할 수 있을까?<br>→ ***글로 쓴 전통매듭 도안을 이미지 도안으로 보여주자!***

✅ 도안에 들어가는 매듭들을 육안으로 확인할 수 있어서 매듭 이름을 찾아보지 않고 바로 매듭을 묶을 수 있다!

✅ 결과물의 모양을 실시간으로 확인해가며 매듭을 디자인할 수 있다!

✅ 기존에 손으로 적었던 글 도안들을 이미지 도안으로 변환/저장하여 간편하게 들고다닐 수 있다!

<br>

# 팀원소개


| 김담인(비전) | 양지영(밀루) | 허예강(라프) | 이주현(트란) | 하진주(헤이즐) | 한인우(하니) |
| --- | --- | --- | --- | --- | --- |
| 테크 | 테크 | 테크 | 디자인 | 디자인 | 디자인 |
| ![미모지_비전](https://github.com/DeveloperAcademy-POSTECH/2024-MC2-A4-HATVIMILHARA/assets/167414750/d2f2a4ba-6e2c-4352-aa9d-f1da85ac256a) | ![미모지_밀루](https://github.com/DeveloperAcademy-POSTECH/2024-MC2-A4-HATVIMILHARA/assets/167414750/8860696b-1d7d-45af-95ea-cbd81a539f34) | ![미모지_라프](https://github.com/DeveloperAcademy-POSTECH/2024-MC2-A4-HATVIMILHARA/assets/167414750/65d38a97-1b30-4f16-b73d-278a3ba773ae) | ![미모지_트란](https://github.com/DeveloperAcademy-POSTECH/2024-MC2-A4-HATVIMILHARA/assets/167414750/f8fa28c9-e427-45c0-952c-f0b644cfd3e5) | ![미모지_헤이즐](https://github.com/DeveloperAcademy-POSTECH/2024-MC2-A4-HATVIMILHARA/assets/167414750/0197bc67-394f-4009-9ab2-bbacdb5913f8) | ![Hani_한인우_20020628_미모지](https://github.com/DeveloperAcademy-POSTECH/2024-MC2-A4-HATVIMILHARA/assets/167414750/4bbf9ac9-8003-43e3-8c9e-58476ff6ee32)
| ekadls757@gmail.com | sophiathedev@gmail.com | yeggang0602@gmail.com | younglm582302@gmail.com | daydog1122@gmail.com | haninwoo0628@naver.com |

<br>

# 주요기능


***매듭버튼***을 눌러서 리스트에 글 도안을 작성하면 그 매듭에 해당하는 이미지가 ***그림 도안 뷰***에 나타난다.

***글 도안 뷰***에서 리스트를 이동 및 삭제하면 ***그림 도안 뷰***에 반영된다.

<div align="center">

| [홈화면] | [패턴뷰 첫화면] |
| --- | --- |
| <img width="1292" alt="Untitled 3" src="https://github.com/DeveloperAcademy-POSTECH/2024-MC2-A4-HATVIMILHARA/assets/167414750/1757c851-639e-4c10-b69a-4eb29ca76291"> | <img width="1292" alt="Untitled 4" src="https://github.com/DeveloperAcademy-POSTECH/2024-MC2-A4-HATVIMILHARA/assets/167414750/93919a47-3470-489f-a35e-bae73eac69d9">

| [이미지 도안 제작하는 과정] | [편집모드] |
| --- | --- |
| <img width="1292" alt="Untitled 5" src="https://github.com/DeveloperAcademy-POSTECH/2024-MC2-A4-HATVIMILHARA/assets/167414750/e43f5e60-a0db-43a7-8130-bf3f3fd27b84"> | <img width="1292" alt="Untitled 6" src="https://github.com/DeveloperAcademy-POSTECH/2024-MC2-A4-HATVIMILHARA/assets/167414750/9acfb291-84b1-4462-9105-78e375964527"> |

</div>

<br>


# **🛠️** Development Environment

<div align="center">
  
![Xcode badge](https://img.shields.io/badge/Xcode-15.4-blue)<br>
![iOS badge](https://img.shields.io/badge/iOS-17.2%2B-green)

</div>

<br>

# **✨Tech Stack**



```swift
import AVKit
import Combine
import Foundation
import SwiftData
import SwiftUI
import Observation
import UIKit
```

<br>

# **📁 폴더링**


```
Dorae
  |
  └── Dorae
          |── 🗂 Model
          │   │── 📄 Pattern.swift
          │   └── 📄 Knot.swift
          │
          |── 🗂 Views
          │   │── 📁 Home
          │   └── 📁 Pattern
          │         │── 📁 TextPatten
          │         │── 📁 KnotList
          │         └── 📁 ImagePattern
          │
          |── 🗂 ViewModel
          │   └── 📁 ImagePattern
          │
          |── 🗂 Resources
          │   └── 📁 KnotList
          │
          |── 🗂 Extensions
          │
          |── 🗂 Utilities
          │
          └── 🗂 Splash
             

```

<br>

# **📔 커밋 컨벤션**


```swift
[**작업**] #**이슈번호**-**커밋제목**

Chore: #1-그냥 보통 잡일
Feat: #1-새로운 주요 기능 추가
Add: #2-파일 추가, 에셋 추가, etc
Fix: #2-버그 수정
Del: #2-쓸모없는 코드, 뭐 어쩌고 삭제
Refactor: #2-코드 리팩토링 -> 결과는 똑같음. 근데 코드가 달라짐
Move: #2-프로젝트 구조 변경(폴더링 등)
Rename: #2-파일, 클래스, 변수명 등 이름 변경
Docs: #2-Wiki, README 파일 수정
```
