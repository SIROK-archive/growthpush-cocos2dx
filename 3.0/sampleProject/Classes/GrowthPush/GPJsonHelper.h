//
//  GPJsonHelper.h
//  growthpush-cocos2dx
//
//  Created by TSURUDA Ryo on 2013/12/11.
//  Copyright (c) 2013年 TSURUDA Ryo. All rights reserved.
//

#ifndef __GROWTHPUSHPLUGIN_GPJSONHELPER_H__
#define __GROWTHPUSHPLUGIN_GPJSONHELPER_H__

#include "cocos2d.h"
#include "json/document.h"

#include "GPMacros.h"

NS_GROWTHPUSH_BEGIN

class GPJsonHelper
{
public:
    
/**
 * Parse JSON string to Value.
 *
 * @param json  JSON string.
 * @return parsed Value value.
 */
static cocos2d::Value parseJson2Value(const std::string &json){
    rapidjson::Document d;

    if (d.Parse<0>(json.c_str()).HasParseError()) {
        CCLOGERROR("failed to parse json:%s", d.GetParseError());
        return cocos2d::Value::Null;
    }
    return convertJson2Value(d);
}

private:
    
static cocos2d::Value convertJson2Value(const rapidjson::Value &v){

    if (v.IsObject()) {
        return convertJson2Map(v);
    }
    if (v.IsArray()) {
        return convertJson2Vector(v);
    }
    if (v.IsString()) {
        return convertJson2String(v);
    }
    if (v.IsInt()) {
        return convertJson2Int(v);
    }
    if (v.IsNumber()) {
        return convertJson2Double(v);
    }
    if (v.IsBool()) {
        return convertJson2Bool(v);
    }
    if (v.IsNull()) {
        return convertJson2Null(v);
    }

    CCLOGERROR("failed to convert: Unknown value type");
    return cocos2d::Value::Null;

}

static cocos2d::Value convertJson2Map(const rapidjson::Value &v){

    cocos2d::ValueMap dictionary;

    for (rapidjson::Value::ConstMemberIterator it = v.MemberonBegin(); it != v.MemberonEnd(); ++it) {
        cocos2d::Value value = convertJson2Value(it->value);
        dictionary.insert(std::make_pair(it->name.GetString(), value));
    }
    return cocos2d::Value(dictionary);

}

static cocos2d::Value convertJson2Vector(const rapidjson::Value &v){
    
    cocos2d::ValueVector array;

    for (rapidjson::Value::ConstValueIterator it = v.onBegin(); it != v.onEnd(); ++it) {
        cocos2d::Value value = convertJson2Value(*it);
        array.push_back(value);
    }
    return cocos2d::Value(array);

}

static cocos2d::Value convertJson2String(const rapidjson::Value &v){

    std::string s = v.GetString();

    return cocos2d::Value(s);

}

static cocos2d::Value convertJson2Int(const rapidjson::Value &v){
    
    int d = v.GetInt();
    
    return cocos2d::Value(d);
    
}

static cocos2d::Value convertJson2Double(const rapidjson::Value &v){

    double d = v.GetDouble();

    return cocos2d::Value(d);

}

static cocos2d::Value convertJson2Bool(const rapidjson::Value &v){

    bool b = v.GetBool();

    return cocos2d::Value(b);

}

static cocos2d::Value convertJson2Null(const rapidjson::Value &v){

    CC_UNUSED_PARAM(v);      // ignore value
    return cocos2d::Value::Null;

}
};

NS_GROWTHPUSH_END

#endif  // __GROWTHPUSHPLUGIN_GPJSONHELPER_H__
