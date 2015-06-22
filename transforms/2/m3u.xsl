<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" />
  <xsl:param name="Server" />
  <xsl:template match="/">#EXTM3U
<xsl:value-of select="catalog/cd/title" />
<xsl:for-each select="/TiVoContainer/Item">
<xsl:if test="matches(Details/ContentType,'video/x-tivo-raw-tts')">#EXTINF:<xsl:value-of select="Details/Duration div 1000" />,<xsl:value-of select="Details/EpisodeTitle" /> - <xsl:value-of select="Details/Title" />
      <xsl:variable name="fid">
	<xsl:value-of select="replace(Links/Content/Url,'http://.*id=','')" />
      </xsl:variable>
http://<xsl:value-of select="$Server" />/<xsl:value-of select="$fid" />.mpg
</xsl:if>
</xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
