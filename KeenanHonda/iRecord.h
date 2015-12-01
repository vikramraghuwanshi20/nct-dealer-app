//
//  iRecords.h
//  MobileMoney
//
//  Created by supermandt on 3/20/13.
//  Copyright (c) 2013 Dash Technologies. All rights reserved.
//

#define RESPONSE_SUCCESS @"~SUCCESS~"
#define RESPONSE_ERROR  @"~ERROR~"
#define RESPONSE_REQUIRED  @"~REQUIRED~"
#define RESPONSE_NODATA  @"~NODATA~"
#define HTMLTAG_TOTALRECORDS  @"iTOTALRECORDS"
#define HTMLTAG_TOTALRECORDS_START  @"<iTOTALRECORDS>"
#define HTMLTAG_TOTALRECORDS_END  @"</iTOTALRECORDS>"

#define INTTOSTRING(x)  [NSString stringWithFormat:@"%d",x]


#import <Foundation/Foundation.h>

@interface iRecord : NSObject


+(BOOL)IsSuccess:(NSString *)sdata;
+(BOOL)StringInString:(NSString *)str stringtofind:(NSString *)strfind;
+(NSString *) CreateField:(NSString *)fld  withdata:(NSString *)sdata;
+(NSString *)GetStringBetween:(NSString *)s string1:(NSString *)s1 string2:(NSString *)s2;
+(NSString *) CreateRecord:(NSInteger)nRec  withrec:(NSString *)sRec;
+(NSString *) GetRecord:(NSInteger)nRec withdata:(NSString *)sdata;
+(NSString *) EncodeHtml:(NSString *)xmldata;
+(NSString *) DecodeHtml:(NSString *)xmldata;
+(NSString *) CreateTotalRecordsString:(NSInteger)nRecords;
+(NSInteger) GetTotalRecords:(NSString *)sdata;
+(void)CallNCloud:(NSString *)xmlParameters setdelegate:(id)dele;
+(void)CallNCloudLIVE:(NSString *)xmlParameters setdelegate:(id)dele;

+(NSString *) GetField:(NSString *)fld  withdata:(NSString *)sdata;
+(NSString *) FixEscapeCodes:(NSString *)xmldata;


@end



//    public class iRecord
//    {
//        static public string RESPONSE_SUCCESS = "~SUCCESS~";
//        static public string RESPONSE_ERROR = "~ERROR~";
//        static public string RESPONSE_REQUIRED = "~REQUIRED~";
//        static public string RESPONSE_NODATA = "~NODATA~";
//
//        static public string HTMLTAG_TOTALRECORDS = "iTOTALRECORDS";
//        static public string HTMLTAG_TOTALRECORDS_START = "<iTOTALRECORDS>";
//        static public string HTMLTAG_TOTALRECORDS_END = "</iTOTALRECORDS>";
//
//
//        static public bool IsSuccess(string sdata)
//        {
//            if (string.IsNullOrEmpty(sdata))
//            {
//                return false;
//            }
//            return sdata.IndexOf(RESPONSE_SUCCESS) >= 0;
//        }
//
//
//        static public Int32 GetTotalRecords(string sdata)
//        {
//            if (string.IsNullOrEmpty(sdata))
//            {
//                return 0;
//            }
//
//            string t = GetStringBetween(sdata, HTMLTAG_TOTALRECORDS_START, HTMLTAG_TOTALRECORDS_END);
//            if (string.IsNullOrEmpty(t))
//            {
//                return 0;
//            }
//            return Convert.ToInt32(t);
//
//        }
//
//
//        static public string CreateTotalRecordsString(Int32 nRecords)
//        {
//            string fmt = HTMLTAG_TOTALRECORDS_START + "{0}" + HTMLTAG_TOTALRECORDS_END;
//            return string.Format(fmt, nRecords);
//        }
//
//
//        static public string CreateField(string fld, string data)
//        {
//            if (string.IsNullOrEmpty(data))
//            {
//                data = " ";
//            }
//            return "<" + fld + ">" + data + "</" + fld + ">";
//        }
//
//        static public string CreateRecord(int nRec, string sRec)
//        {
//            if (string.IsNullOrEmpty(sRec))
//            {
//                sRec = " ";
//            }
//
//            return "<irecord" + nRec.ToString() + ">" + sRec + "</irecord" + nRec.ToString() + ">";
//
//        }
//
//
//        static public string GetRecord(int nRecord, string sdata)
//        {
//
//            string irecstart = "<irecord" + nRecord.ToString() + ">";
//            string irecend = "</irecord" + nRecord.ToString() + ">";
//            return GetStringBetween(sdata, irecstart, irecend);
//        }
//
//
//        static public string GetField(string fld, string sdata)  // no brackets needed pass in field name only like fname, NOT <fname></fname>
//        {
//
//            string irecstart = "<" + fld + ">";
//            string irecend = "</" + fld + ">";
//            return GetStringBetween(sdata, irecstart, irecend);
//        }
//
//        static public string DecodeHtml(string xmldata)
//        {
//            if (string.IsNullOrEmpty(xmldata))
//	        {
//                return string.Empty;
//	        }
//            return HttpUtility.HtmlDecode(xmldata);
//        }
//
//
//        static public string EncodeHtml(string xmldata)
//        {
//            if (string.IsNullOrEmpty(xmldata))
//            {
//                return string.Empty;
//            }
//            return HttpUtility.HtmlEncode(xmldata);
//        }
//
//
//        static public string GetStringBetween(string sData, string init_tag, string end_tag)
//        {
//
//            if (string.IsNullOrEmpty(sData))
//            {
//                return string.Empty;
//            }
//
//
//            int start = sData.IndexOf(init_tag);
//            if (start == -1)
//            {
//                return string.Empty;
//            }
//            int end = sData.IndexOf(end_tag);
//            if (end == -1)
//            {
//                return string.Empty;
//            }
//
//            string result = sData.Substring(start, (end - start));
//            result = result.Replace(init_tag, "");
//            result = result.Replace(end_tag, "");
//            return result;
//
//        }
//
//
//    }
