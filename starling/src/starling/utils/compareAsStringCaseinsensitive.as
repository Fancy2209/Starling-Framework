// =================================================================================================
//
//	Starling Framework
//	Copyright Gamua GmbH. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package starling.utils
{
    // From https://github.com/apache/royale-asjs/blob/66448244701f269de6763683f261ef413b7ba897/frameworks/projects/Language/src/main/royale/org/apache/royale/utils/Language.as#L414-L422
    /** @private */
    public function compareAsStringCaseinsensitive(a:Object, b:Object):int
    {
        var zeroStr:String = String.fromCharCode(0);
        var v:int = (a || zeroStr).toString().toLowerCase().localeCompare((b || zeroStr).toString().toLowerCase());
        if (v != 0)
        {
            return v * 1;
        }
        return 0;
    }
}