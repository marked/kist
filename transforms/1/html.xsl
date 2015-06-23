<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:ks="http://www.ks.me"	
		xmlns:func="http://exslt.org/functions"
                extension-element-prefixes="func date"
xmlns:date="http://exslt.org/dates-and-times"
exclude-result-prefixes="ks xs"
		>
  
  
  <xsl:param name="Container" select="'/NowPlaying'" />
  <xsl:param name="Recurse" select="'No'" />
  <xsl:param name="TZ" select="-5" />
  <xsl:param name="ItemCount" select="16" />
  <xsl:param name="Referrer" />
  <xsl:param name="Query" />
  <xsl:param name="Server" />
  <xsl:variable name="offset" select="$TZ*3600*1000*date:duration('PT0.001S')" />
  
  <func:function name="ks:hexDate2decDate">
    <xsl:param name="hexString" />
    <xsl:choose>
      <xsl:when test="$hexString = '0'">
	<func:result select="0" />
      </xsl:when>
      <xsl:when test="$hexString = '1'">
	<func:result select="1" />
      </xsl:when>
      <xsl:when test="$hexString = '2'">
	<func:result select="2" />
      </xsl:when>
      <xsl:when test="$hexString = '3'">
	<func:result select="3" />
      </xsl:when>
      <xsl:when test="$hexString = '4'">
	<func:result select="4" />
      </xsl:when>
      <xsl:when test="$hexString = '5'">
	<func:result select="5" />
      </xsl:when>
      <xsl:when test="$hexString = '6'">
	<func:result select="6" />
      </xsl:when>
      <xsl:when test="$hexString = '7'">
	<func:result select="7" />
      </xsl:when>
      <xsl:when test="$hexString = '8'">
	<func:result select="8" />
      </xsl:when>
      <xsl:when test="$hexString = '9'">
	<func:result select="9" />
      </xsl:when>
      <xsl:when test="$hexString = 'A'">
	<func:result select="10" />
      </xsl:when>
      <xsl:when test="$hexString = 'B'">
	<func:result select="11" />
      </xsl:when>
      <xsl:when test="$hexString = 'C'">
	<func:result select="12" />
      </xsl:when>
      <xsl:when test="$hexString = 'D'">
	<func:result select="13" />
      </xsl:when>
      <xsl:when test="$hexString = 'E'">
	<func:result select="14" />
      </xsl:when>
      <xsl:when test="$hexString = 'F'">
	<func:result select="15" />
      </xsl:when>
      <xsl:otherwise>
	<func:result select="16*ks:hexDate2decDate(substring($hexString,1,string-length($hexString)-1))+ks:hexDate2decDate(substring($hexString,string-length($hexString),1))" />
      </xsl:otherwise>
    </xsl:choose>
  </func:function>
  
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
	  <tr bgcolor="#E5E5C5">
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
		<xsl:when test="position() mod 2 = 1">#F5F5B5</xsl:when>
		<xsl:otherwise>#F5F595</xsl:otherwise>
	      </xsl:choose>
	    </xsl:variable>
	    <tr bgcolor="{$row_color}">
	      <xsl:variable name="imgname">
		<xsl:value-of select="substring-after(Links/CustomIcon/Url,'urn:tivo:image:')" />
	      </xsl:variable>
	      <td>
		<xsl:if test="string-length($imgname)">
		  <img src="html/images/{$imgname}.png" />
		</xsl:if>
	      </td>
	      <td>
		<xsl:if test="Details/SourceChannel">
		  <xsl:variable name="channel_num" select="translate(Details/SourceChannel,'-','.')" />
		  <img src="html/images/logos/{$channel_num}.png" /><br />
		  <xsl:value-of select="$channel_num" />&#160;<xsl:value-of select="Details/SourceStation" />
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
	      <td class="dateField">
		<xsl:if test="Details/CaptureDate">
		  <xsl:variable name="capture_date_dec" select="ks:hexDate2decDate(substring(Details/CaptureDate,3))" />
		  
		  <xsl:variable name="capture_date_s" select="date:add(date:date('1970-01-01'),concat('P',floor((($capture_date_dec div 3600) + 0) div 24) ,'D'))" />
		  
		  <xsl:value-of select="date:day-abbreviation($capture_date_s)" /><br />
		  <xsl:value-of select="date:month-in-year($capture_date_s)" />/<xsl:value-of select="date:day-in-month($capture_date_s)" />/<xsl:value-of select="date:year($capture_date_s)" /><br />
		 
		  <xsl:variable name="capture_time_s" select="($capture_date_dec mod (60*60*24))" />
		  <xsl:value-of select="floor($capture_time_s div 3600)" />:<xsl:value-of select="format-number(floor($capture_time_s mod 3600 div 60),'00')" />:<xsl:value-of select="format-number($capture_time_s mod 60,'00')" /><br />
		  [&#160;<span class="hexDate"><xsl:value-of select="substring(Details/CaptureDate,3)" /></span>&#160;]
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
		      <xsl:value-of select="substring-after(Links/Content/Url, 'Container=')" />
		    </xsl:variable>
		    <a href="NowPlaying.html?Container={$pathid}">folder</a>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:variable name="fid" select="substring-after(Links/Content/Url,'id=')" />
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
