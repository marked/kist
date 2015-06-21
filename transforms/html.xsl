<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:ks="http://www.ks.me"	
		>
  
  <xsl:param name="Container" select="'/NowPlaying'" />
  <xsl:param name="Recurse" select="'No'" />
  <xsl:param name="TZ" select="-5" />
  <xsl:param name="ItemCount" select="16" />
  <xsl:param name="Referrer" />
  <xsl:param name="Query" />
  <xsl:param name="Server" />
  <xsl:variable name="offset" select="$TZ*3600*1000*xs:dayTimeDuration('PT0.001S')" />
  
  <xsl:function name="ks:hexDate2decDate">
    <xsl:param name="hexString" />
    <xsl:choose>
      <xsl:when test="string-length($hexString) = 1">
	<xsl:value-of select="string-to-codepoints(translate($hexString,'ABCDEF','&#58;&#59;&#60;&#61;&#62;&#63;'))-48" />
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="16*ks:hexDate2decDate(substring($hexString,1,string-length($hexString)-1))+ks:hexDate2decDate(substring($hexString,string-length($hexString),1))" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <xsl:template match="/">
    <html>
      <head>
	<title>Now Playing</title>
	<link rel="stylesheet" href="html/style.css" type="text/css" media="all" />
	<link rel="alternate" type="text/xml" title="RSS 2.0" href="/NowPlaying.rss" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      </head>
      <body>
	<img src="html/images/tivodance.gif" align="right" />
	<table>
	  <tr>
	    <td><h1>Now Playing</h1></td>
	    <td><a href="NowPlaying.m3u{$Query}">.m3u</a> | <a href="NowPlaying.rss{$Query}">.rss</a> | <a href="NowPlaying.xml{$Query}">.xml</a></td>
	  </tr>
	</table>
	<table cellpadding="7" width="100%">
	  <tr bgcolor="E5E5C5">
	    <th width="1%"></th>
	    <th width="1%">Source</th>
	    <th>Description</th>
	    <th width="5%">Date</th>
	    <th width="5%">Size</th>
	    <th width="5%">Links</th>
	  </tr>
	  <xsl:for-each select="TiVoContainer/Item">
	    <xsl:variable name="row_color">
	      <xsl:choose>
		<xsl:when test="position() mod 2 = 1">F5F5B5</xsl:when>
		<xsl:otherwise>F5F595</xsl:otherwise>
	      </xsl:choose>
	    </xsl:variable>
	    <tr bgcolor="{$row_color}">
	      <xsl:variable name="imgname">
		<xsl:value-of select="replace(Links/CustomIcon/Url,'urn:tivo:image:','')" />
	      </xsl:variable>
	      <td>
		<xsl:if test="string-length($imgname)">
		  <img src="html/images/{$imgname}.png" />
		</xsl:if>
	      </td>
	      <td>
		<xsl:if test="Details/SourceChannel">
		  <xsl:variable name="channel_num" select="replace(Details/SourceChannel,'-','.')" />
		  <img src="html/images/logos/{$channel_num}.png" /><br />
		  <xsl:value-of select="$channel_num" />_<xsl:value-of select="replace(Details/SourceStation,'(DT|HD)','')" />
		</xsl:if>
	      </td>
	      <td>
		<b><xsl:value-of select="Details/Title" /></b><br />
		<xsl:if test="string-length(Details/EpisodeTitle)">
		  <b>
		    <xsl:value-of select="Details/EpisodeTitle" />: 
		  </b>
		</xsl:if>
		<xsl:value-of select="Details/Description" />
	      </td>
	      <td>
		<xsl:if test="Details/CaptureDate">
		  <xsl:value-of select="format-dateTime(xs:dateTime('1970-01-01T00:00:00') + ks:hexDate2decDate(replace(Details/CaptureDate,'0x','')) *1000* xs:dayTimeDuration('PT0.001S')+$offset, '[FNn,3-3] [M1]/[D1]/[Y01] [H]:[m]:[s][Z][z]')"/> 
		  <br /> 
[&#160;<xsl:value-of select="replace(Details/CaptureDate,'0x','')" />&#160;]
		</xsl:if>
	      </td>
	      <td>
		<xsl:choose>
		  <xsl:when test="Details/TotalItems">
		    <xsl:value-of select="Details/TotalItems" />&#160;items
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:value-of select="              floor(Details/Duration div 1000 div 3600)" />:<xsl:value-of select="format-number(floor(Details/Duration div 1000 mod 3600 div 60), '00')" />:<xsl:value-of select="format-number(floor(Details/Duration div 1000 mod 60), '00')" />
		    <br />
		    <xsl:value-of select="format-number(Details/SourceSize div 1024 div 1024 div 1024, '#.##')" />&#160;GB<br /> 
		  </xsl:otherwise>
		</xsl:choose>
	      </td>
	      <td>
		<xsl:choose>
		  <xsl:when test="Details/TotalItems">
		    <xsl:variable name="pathid">
		      <xsl:value-of select="replace(Links/Content/Url, 'http.*(Container=[a-zA-Z0-9%]+)', '$1')" />
		    </xsl:variable>
		    <a href="NowPlaying.html?{$pathid}">folder</a>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:variable name="fid" select="replace(Links/Content/Url,'http://.*id=','')" />
		    <xsl:variable name="fsize" select="Details/SourceSize" />
		    <xsl:choose>
		      <xsl:when test="Details/ByteOffset">
			<xsl:variable name="foffset" select="Details/ByteOffset" />
		    <a href="/{$fid}.mpg">Play</a>&#160;|&#160;<a href="/{$fid}.mpg?{$foffset}"><xsl:value-of select="format-number($foffset * 100 div $fsize,'0')" />%</a><br />
		      </xsl:when>
		      <xsl:otherwise>
			<xsl:variable name="foffset" select="0" />
		          <a href="/{$fid}.mpg">Play</a>&#160;|&#160;<a href="/{$fid}.mpg?{$foffset}"><xsl:value-of select="format-number($foffset * 100 div $fsize,'0')" />%</a><br />
		      </xsl:otherwise>
		    </xsl:choose>
		    
		
		    <a href="/{$fid}.xml">Details</a>
		  </xsl:otherwise>
		</xsl:choose>
	      </td>
	    </tr>
	  </xsl:for-each>
	</table>
	<xsl:value-of select="/TiVoContainer/ItemCount" />
	items, <b>(out of 
	<xsl:value-of select="/TiVoContainer/Details/TotalItems" />
	total items)</b><br />
	<a href="NowPlaying.html?Recurse=Yes">Classic view</a> | <a href="NowPlaying.html?Recurse=No">Group view</a><br />
	<xsl:variable name="PrevOff">
	  <xsl:value-of select="/TiVoContainer/ItemStart - $ItemCount" />
	</xsl:variable>
	<xsl:variable name="NextOff">
	  <xsl:value-of select="/TiVoContainer/ItemStart + $ItemCount" />
	</xsl:variable>
	<a href="NowPlaying.html?Container={$Container}&amp;Recurse={$Recurse}&amp;AnchorOffset={$PrevOff}">Prev</a> | <a href="NowPlaying.html?Container={$Container}&amp;Recurse={$Recurse}&amp;AnchorOffset={$NextOff}">Next</a>
	<p />
	Referrer = <a href="{$Referrer}"><xsl:value-of select="$Referrer" /></a> <br />
	Recurse = <xsl:value-of select="$Recurse" /> <br />
	Server = <xsl:value-of select="$Server" /> <br />
	Query = <xsl:value-of select="$Query" /> <br />
	<p />
	<font size="-2">This feature is not supported. The TiVo license agreement allows you to transfer content to up to ten devices within your household, but not outside your household.  Unauthorized transfers or distribution of copyrighted works outside of your home may constitute a copyright infringement. TiVo reserves the right to terminate the TiVo service accounts of users who transfer or distribute content in violation of this Agreement. </font>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
