////
////  SwiftDataTestView.swift
////  Dorae
////
////  Created by 지영 on 5/25/24.
////
//
//import SwiftUI
//import SwiftData
//
//struct SwiftDataTestView: View {
//    @Query var patterns: [Pattern]
//    @Environment(KnotDataManager.self) var knotDataManager
//
//    var body: some View {
//        NavigationStack{
//            VStack{
//                ForEach(patterns) { pattern in
//                    var knotList = pattern.knotList
//                    ForEach(knotList) { knot in
////                        knotDataManager.knotList.append(knot)
//                    }
//                    Text("\(knotList)")
//                                       
//                }
//            }
//        }
//    }
//}
//
//
//
////#Preview {
////    // configuration 설정
////    let config = ModelConfiguration(isStoredInMemoryOnly: true)
////    // 특정 타입을 저장할 컨테이너 생성
////    let containter: ModelContainer = {
////        let schema = Schema([
////            Pattern.self,
////        ])
////        
////        do {
////            return try ModelContainer(for: schema, configurations: config)
////        } catch {
////            fatalError("Could not create ModelContainter: \(error)")
////        }
////        
////    }()
////    containter.mainContext.insert(Pattern(knotList: [
////        .etc(knot: EtcKnot(interval: 0)),
////        .etc(knot: EtcKnot(lasso: "lasso가 뭐야"))
////        
////    ], createdAt: "00 생성됨", title: "패턴1", braid: "123"))
//////    containter.mainContext.insert(Pattern(knotList: [
//////        .basic(knot: 도래매듭),
//////        .basic(knot: 귀도래매듭),
//////    ], createdAt: "01 생성됨", title: "패턴2", braid: "123"))
//////    containter.mainContext.insert(Pattern(knotList: [
//////        .applied(knot: 항아리매듭),
//////        .applied(knot: 육립매듭),
//////        .applied(knot: 공작매듭),
//////        .applied(knot: 스타매듭)
//////    ], createdAt: "02 생성됨", title: "패턴3", braid: "123"))
////    
////    
////    return SwiftDataTestView()
////        .modelContainer(containter)
////        .environment(KnotDataManager())
////    
////}
