//
//  VSViewModelProtocol.h
//  Spec
//
//  Created by leo on 2017/11/2.
//  Copyright © 2017年 Vipshop Holdings Limited. All rights reserved.
//

#ifndef VSViewModelProtocol_h
#define VSViewModelProtocol_h

@protocol VSCellModelProtocol;
@protocol VSSectionModelProtocol;
@protocol VSViewModelProtocol <NSObject>
@property (nonatomic, strong) NSMutableArray<id<VSSectionModelProtocol>> *sectionModelArray;

- (NSUInteger)numberOfSections;

- (id<VSSectionModelProtocol>)sectionModelInSection:(NSInteger)section;

- (NSUInteger)numberOfRowsInSection:(NSInteger)section;

- (NSString *)cellClassNameForRowAtIndexPath:(NSIndexPath *)indexPath;

- (id<VSCellModelProtocol>)cellModelAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSString *)title;

- (void)enumerateCellClassNamesUsingBlock:(void (^)(NSString *cellClassName))block;

@end

#endif /* VSViewModelProtocol_h */
