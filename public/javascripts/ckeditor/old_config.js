/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
  config.uiColor = '#999';
  config.resize_enabled = false;

  config.toolbar = 'Full';
  
  config.toolbar_Full =
    [
        ['Source'],
        ['Cut','Copy','Paste','PasteText','PasteFromWord',],
        ['Styles','Format'],
        ['Link','Unlink','Anchor'],
		'/',
        ['Bold','Italic','Underline','Strike','-','Subscript','Superscript', 'TextColor'],
        ['NumberedList','BulletedList','-','Outdent','Indent'],
        ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock']
    ];
};

