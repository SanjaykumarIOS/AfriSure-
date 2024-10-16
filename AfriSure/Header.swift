//
//  Header.swift
//  AfriSure
//
//  Created by iosdevelopment on 05/01/24.
//

import Foundation
import SwiftUI

//public let BaseURL = "https://primez-uat-api.azurewebsites.net/"
//public let BaseURL = "https://primez.insure.digital/"

public let BaseURL = "https://demo-prodconfig-api-primez.insure.digital/"
public let loginBaseURL = "https://uat-uad-primez.insure.digital/"



let proposalFormJsonData = """
{
  "rcode": 200,
  "rObj": {
    "formDataJson": "",
    "fetchFormData": {
      "formsMappingID": "6ec36237-80f9-4489-88b7-cdcddb52f4c4",
      "orgFormID": "ecc1ab41-c5c7-4ba9-aa76-f359e991ed33",
      "formName": "Health Insurance",
      "formRefID": "0b7082fd-f421-41c2-963c-ea9f21ef0c3d",
      "versionNumber": 5,
      "versionCode": "VE-005",
      "isCurrentVersion": true,
      "upts": "14-Mar-2024 05:25",
      "upUser": "bf63ca6b-e722-442a-a876-122c6a068b0e",
      "upUserName": "User300 LastName300",
      "formData": [
        {
          "fieldGroupClassName": "row",
          "fieldGroup": [
            {
              "type": "input",
              "templateOptions": {
                "label": "First Name",
                "isAmount": null,
                "placeholder": "Enter First Name",
                "required": true,
                "readOnly": false,
                "minLength": 3,
                "maxLength": 20
              },
              "validation": {
                "messages": {
                  "required": "First Name is Required",
                  "minLength": "First Name should have at least 3 character",
                  "maxLength": "First Name should not exceed 20 character"
                }
              },
              "key": "InsuredFirstName",
              "className": "col-md-12",
              "wrappers": [
                "tooltip-icon"
              ],
              "defaultValue": null
            },
            {
              "type": "input",
              "templateOptions": {
                "label": "Password",
                "type": "password",
                "placeholder": "Enter Password",
                "required": true,
                "readOnly": false,
                "pattern": "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$",
                "minLength": "3",
                "maxLength": "20"
              },
              "validation": {
                "messages": {
                  "required": "Password is Required",
                  "pattern": "Password is Invalid",
                  "minLength": "Password should have at least 3 character",
                  "maxLength": "Password should not exceed 20 character"
                }
              },
              "key": "password",
              "className": "col-md-12",
              "wrappers": [
                "tooltip-icon"
              ],
              "defaultValue": null
            },
            {
              "type": "textarea",
              "templateOptions": {
                "label": "Address ",
                "rows": 5,
                "placeholder": "Enter Address ",
                "required": true,
                "readOnly": false,
                "minLength": 3,
                "maxLength": 1000
              },
              "validation": {
                "messages": {
                  "required": "Address  is Required",
                  "minLength": "Address  should have at least 3 character",
                  "maxLength": "Address  should not exceed 1000 character"
                }
              },
              "key": "InsuredAddressLine1",
              "className": "col-md-12",
              "wrappers": [
                "tooltip-icon"
              ],
              "defaultValue": null
            },
            {
              "type": "checkbox",
              "templateOptions": {
                "label": "Terms and Conditions",
                "indeterminate": false,
                "required": true,
                "readOnly": false
              },
              "defaultValue": null,
              "validation": {
                "messages": {
                  "required": "Terms and Conditions is Required"
                }
              },
              "key": "terms",
              "className": "col-md-12",
              "wrappers": [
                "tooltip-icon"
              ]
            },
            {
              "type": "select",
              "templateOptions": {
                "label": "Country",
                "options": [
                  {
                    "label": "India",
                    "value": "1"
                  },
                  {
                    "label": "Kenya",
                    "value": "2"
                  }
                ],
                "isOnloadAPICall": false,
                "placeholder": "Select",
                "required": true,
                "readOnly": false
              },
              "validation": {
                "messages": {
                  "required": "Country is Required"
                }
              },
              "key": "countryID",
              "className": "col-md-12",
              "wrappers": [
                "tooltip-icon"
              ],
              "defaultValue": null
            },
            {
              "type": "select",
              "templateOptions": {
                "label": "Vehicle Make",
                "options": [],
                "isOnloadAPICall": true,
                "rObjData": "rObj.fetchMasterData",
                "apiUrl": "api/prodconfig/MST/MasterData/FetchMasterData",
                "baseApiUrlType": "product_config",
                "categoryID": 460,
                "valueProp": "masterDataID",
                "labelProp": "mdTitle",
                "placeholder": "Select",
                "required": true,
                "readOnly": false
              },
              "validation": {
                "messages": {
                  "required": "Vehicle Make is Required"
                }
              },
              "key": "VehicleMakeID",
              "className": "col-md-12",
              "wrappers": [
                "tooltip-icon"
              ],
              "defaultValue": null
            },
            {
              "type": "select",
              "templateOptions": {
                "label": "Vehicle Model",
                "options": [],
                "cascadingParentControl": "VehicleMakeID",
                "inputParameter": "parentMasterDataID",
                "rObjData": "rObj.fetchMasterData",
                "isOnloadAPICall": false,
                "apiUrl": "api/prodconfig/MST/MasterData/FetchMasterData",
                "baseApiUrlType": "product_config",
                "categoryID": 470,
                "valueProp": "masterDataID",
                "labelProp": "mdTitle",
                "placeholder": "Select",
                "required": true,
                "readOnly": false
              },
              "validation": {
                "messages": {
                  "required": "Vehicle Model is Required"
                }
              },
              "key": "VehicleModelID",
              "className": "col-md-12",
              "wrappers": [
                "tooltip-icon"
              ],
              "defaultValue": null
            },
            {
              "type": "radio",
              "templateOptions": {
                "label": "Gender",
                "options": [
                  {
                    "label": "Male",
                    "value": "1"
                  },
                  {
                    "label": "Female",
                    "value": "2"
                  },
                  {
                    "label": "Others",
                    "value": "3"
                  }
                ],
                "isOnloadAPICall": false,
                "required": true,
                "readOnly": false
              },
              "validation": {
                "messages": {
                  "required": "Gender is Required"
                }
              },
              "key": "genderID",
              "className": "col-md-12",
              "wrappers": [
                "tooltip-icon"
              ],
              "defaultValue": null
            },
{
  "type": "radio",
  "templateOptions": {
    "label": "Usage Type",
    "options": [],
    "isOnloadAPICall": true,
    "rObjData": "rObj.fetchMasterData",
    "apiUrl": "api/prodconfig/MST/MasterData/FetchMasterData",
    "baseApiUrlType": "product_config",
    "categoryID": 641,
    "valueProp": "masterDataID",
    "labelProp": "mdTitle",
    "isParameterNeed": true,
  
    "required": true,
    "readOnly": false
  },
  "validation": {
    "messages": {
      "required": "Usage Type is Required"
    }
  },
  "key": "VehicleUsageTypeID",
  "className": "col-md-12",
  "wrappers": [
    "tooltip-icon"
  ],
  "defaultValue": null
},
    {
        "type": "datepicker",
        "templateOptions": {
          "isDependency": false,
          "label": "Date Of Birth",
          "dateMinType": null,
          "countMin": null,
          "dateMaxType": "year_backward",
          "countMax": 17,
          "datepickerOptions": {
            "min": null,
            "max": null
          },
          "required": true,
          "readOnly": false
        },
        "validation": {
          "messages": {
            "required": "Date Of Birth is Required"
          }
        },
        "key": "InsuredDateOfBirth",
        "className": "col-md-12",
        "wrappers": [
          "tooltip-icon"
        ],
        "defaultValue": null
      },
      {
        "type": "datepicker",
        "templateOptions": {
          "isDependency": false,
          "label": "Start Date",
          "dateMinType": "date_forward",
          "countMin": 0,
          "dateMaxType": "year_forward",
          "countMax": 100,
          "datepickerOptions": {
            "min": null,
            "max": null
          },
          "required": true,
          "readOnly": false
        },
        "validation": {
          "messages": {
            "required": "Start Date is Required"
          }
        },
        "key": "startDate",
        "className": "col-md-12",
        "wrappers": [
          "tooltip-icon"
        ],
        "defaultValue": null
      },
      {
        "type": "datepicker",
        "templateOptions": {
          "label": "End Date",
          "isDependency": true,
          "dateParentControl": "startDate",
          "dateTypeMinDepent": "date_forward",
          "countMinDepent": 0,
          "dateTypeMaxDepent": "year_forward",
          "countMaxDepent": 5,
          "dateMinType": "date_forward",
          "countMin": 0,
          "dateMaxType": "year_forward",
          "countMax": 10,
          "datepickerOptions": {
            "min": null,
            "max": null
          },
          "required": true,
          "readOnly": false
        },
        "validation": {
          "messages": {
            "required": "End Date is Required"
          }
        },
        "key": "endDate",
        "className": "col-md-12",
        "wrappers": [
          "tooltip-icon"
        ],
        "defaultValue": null
      },
{
  "wrappers": [
    "phone-number"
  ],
  "templateOptions": {
    "label": "Phone Number",
    "required": true,
    "readOnly": false
  },
  "defaultValue": null,
  "validation": {
    "messages": {
      "required": "Phone Number is Required"
    }
  },
  "key": "InsuredPhoneNumber"
},
{
  "type": "input",
  "templateOptions": {
    "label": "Upload Document Single",
    "isMultiple": false,
    "fileslength": "1",
    "allowedFileTypes": [
      "image/jpeg",
      "image/png",
      "image/jpg",
      "application/pdf",
      "application/msword",
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "application/vnd.ms-excel",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      "application/vnd.ms-powerpoint",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation",
      "text/plain",
      "application/zip",
      "application/x-rar-compressed",
      "video/mp4",
      "video/quicktime",
      "video/x-msvideo"
    ],
    "maxSize": 2,
    "blopUploadLocation": "",
    "required": true,
    "readOnly": false
  },
  "wrappers": [
    "multi-file-upload"
  ],
  "validation": {
    "messages": {
      "required": "Upload Document Single is Required"
    }
  },
  "key": "uploadDocumentSingle",
  "defaultValue": null
},
{
  "type": "input",
  "templateOptions": {
    "label": "Upload Document Multiple",
    "isMultiple": true,
    "fileslength": "4",
    "allowedFileTypes": [
      "image/jpeg",
      "image/png",
      "image/jpg",
      "application/pdf",
      "application/msword",
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "application/vnd.ms-excel",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      "application/vnd.ms-powerpoint",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation",
      "text/plain",
      "application/zip",
      "application/x-rar-compressed",
      "video/mp4",
      "video/quicktime",
      "video/x-msvideo"
    ],
    "maxSize": 2,
    "blopUploadLocation": "",
    "required": true,
    "readOnly": false
  },
  "wrappers": [
    "multi-file-upload"
  ],
  "validation": {
    "messages": {
      "required": "Upload Document Multiple is Required"
    }
  },
  "key": "UploadDocumentMultiple",
    "defaultValue": null
},
{
  "type": "quill-editor",
  "templateOptions": {
    "label": "Summary",
    "placeholder": "Enter Summary",
    "required": true,
    "readOnly": false
  },
  "validation": {
    "messages": {
      "required": "Summary is Required"
    }
  },
  "key": "summary",
  "className": "col-md-12",
  "wrappers": [
    "tooltip-icon"
  ],
  "defaultValue": null
},
{
  "type": "select",
  "templateOptions": {
    "label": "Line Of Business",
    "options": [
      {
        "label": "Motor",
        "value": "1"
      },
      {
        "label": "Life",
        "value": "2"
      }
    ],
    "multiple": true,
    "placeholder": "Select",
    "required": true,
    "readOnly": false
  },
  "validation": {
    "messages": {
      "required": "Line Of Business is Required"
    }
  },
  "key": "lineOfBusiness",
  "className": "col-md-12",
  "wrappers": [
    "tooltip-icon"
  ],
  "defaultValue": null
},
          ]
        }
      ],
      "formTypeID": "9ce1e66b-2e5e-4dde-9deb-8fbb615438a2",
      "formTypeText": "Proposal Form",
      "lobData": [
        {
          "lobID": "49f3f7ad-4942-476e-9473-5f2f35a86a54",
          "lobName": "Health Insurance"
        }
      ]
    }
  },
  "rmsg": [
    {
      "errorText": "Success",
      "errorCode": "Success",
      "fieldName": null,
      "fieldValue": null
    }
  ],
  "reqID": "0f64a5c0-a90e-4c1d-9962-6363dee56c15",
  "objectDBID": null,
  "transactionRef": null,
  "outcome": true,
  "outcomeMsgCode": "Success",
  "reDirectURL": null,
  "isSuccess": null
}
"""

