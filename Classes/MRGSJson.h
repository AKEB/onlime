//  $Id: MRGSJson.h 301 2012-10-22 13:32:56Z u.lysenkov $
//
//  MRGSJson.h
//  MRGServiceFramework
//
//  Created by Yuriy Lisenkov on 22.10.12.
//  Copyright (c) 2012 Mail.Ru Games. All rights reserved.
//

#ifndef MRGServiceFramework_MRGSJson_
#define MRGServiceFramework_MRGSJson_

#import <Foundation/Foundation.h>

/** Класс MRGSJson. 
 * 
 */
@interface MRGSJson : NSObject {
	
}

#pragma mark -
#pragma mark ПАРАМЕТРЫ
/**  @name ПАРАМЕТРЫ */

#pragma mark -
#pragma mark МЕТОДЫ КЛАССА
/**  @name МЕТОДЫ КЛАССА */

/** Возвращает объект, созданный из строки, либо ноль в случае ошибки.
 * @param string строка с данными в формате json
 * @return Возвращаемый объект может быть string, number, boolean, null, array или dictionary
 */
+(id)objectWithString:(NSString *)string;

/** Возвращает json строку, полученную из объекта.
 * @param object из которого необходимо получить json строку
 * @return Возвращаемый string либо nil в случае ошибки
 */
+(id)stringWithObject:(id)object;

#pragma mark -
#pragma mark МЕТОДЫ ЭКЗЕМПЛЯРА
/**  @name МЕТОДЫ ЭКЗЕМПЛЯРА */

/** Инициализация класса.
 *	@return Возвращает экземпляр класса MRGSJson
 */
-(id)init;

/** Возвращает объект, созданный из строки, либо ноль в случае ошибки.
 * @param string строка с данными в формате json
 * @return Возвращаемый объект может быть string, number, boolean, null, array или dictionary
 */
-(id)objectWithString:(NSString *)string;

/** Возвращает json строку, полученную из объекта.
 * @param object из которого необходимо получить json строку
 * @return Возвращаемый string либо nil в случае ошибки
 */
-(id)stringWithObject:(id)object;


@end


#endif



