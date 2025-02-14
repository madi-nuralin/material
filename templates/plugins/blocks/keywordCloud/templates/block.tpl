{**
 * plugins/blocks/KeywordCloud/block.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- keywords cloud.
 *
 *}

{material_menu_item}
    {material_menu_link}
        {translate key="plugins.block.keywordCloud.title"}
    {/material_menu_link}

    {material_submenu}
        <div class="content wordcloud"></div>

        <script>
            function randomColor() {ldelim}
                var cores = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf'];
                return cores[Math.floor(Math.random()*cores.length)];
            {rdelim}

            {if $keywords}
                document.addEventListener("DOMContentLoaded", function() {ldelim}
                    var keywords = {$keywords};
                    var totalWeight = 0;
                    var blockWidth = 100;
                    var blockHeight = 100;
                    var transitionDuration = 200;
                    var length_keywords = keywords.length;
                    var layout = d3.layout.cloud();

                    layout.size([blockWidth, blockHeight])
                        .words(keywords)
                        .fontSize(function(d)
                        {ldelim}
                            return fontSize(+d.size);
                        {rdelim})
                        .on('end', draw);

                    var svg = d3.selectAll(".wordcloud").append("svg")
                        .attr("viewBox", "0 0 " + blockWidth + " " + blockHeight)
                        .attr("width", '100%');

                    function update() {ldelim}
                        var words = layout.words();
                        fontSize = d3.scaleLinear().range([16, 34]);
                        if (words.length) {ldelim}
                            fontSize.domain([+words[words.length - 1].size || 1, +words[0].size]);
                        {rdelim}
                    {rdelim}

                    keywords.forEach(function(item,index){ldelim}totalWeight += item.size;{rdelim});

                    update();

                    function draw(words, bounds) {ldelim}
                        var width = layout.size()[0],
                            height = layout.size()[1];

                        scaling = bounds
                            ? Math.min(
                                width / Math.abs(bounds[1].x - width / 2),
                                width / Math.abs(bounds[0].x - width / 2),
                                height / Math.abs(bounds[1].y - height / 2),
                                height / Math.abs(bounds[0].y - height / 2),
                            ) / 2
                            : 1;

                        svg
                        .append("g")
                        .attr(
                            "transform",
                            "translate(" + [width >> 1, height >> 1] + ")scale(" + scaling + ")",
                        )
                        .selectAll("text")
                            .data(words)
                        .enter().append("text")
                            .style("font-size", function(d) {ldelim} return d.size + "px"; {rdelim})
                            // .style("font-family", 'serif')
                            .style("fill", randomColor)
                            .style('cursor', 'pointer')
                            .style('opacity', 0.7)
                            .attr('class', 'keyword')
                            .attr("text-anchor", "middle")
                            .attr("transform", function(d) {ldelim}
                                return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
                            {rdelim})
                            .text(function(d) {ldelim} return d.text; {rdelim})
                            .on("click", function(d, i){ldelim}
                                window.location = "{url router=$smarty.const.ROUTE_PAGE page="search" query="QUERY_SLUG"}".replace(/QUERY_SLUG/, encodeURIComponent(''+d.text+''));
                            {rdelim})
                            .on("mouseover", function(d, i) {ldelim}
                                d3.select(this).transition()
                                    .duration(transitionDuration)
                                    .style('font-size',function(d) {ldelim} return (d.size + 3) + "px"; {rdelim})
                                    .style('opacity', 1);
                            {rdelim})
                            .on("mouseout", function(d, i) {ldelim}
                                d3.select(this).transition()
                                    .duration(transitionDuration)
                                    .style('font-size',function(d) {ldelim} return d.size + "px"; {rdelim})
                                    .style('opacity', 0.7);
                            {rdelim})
                            .on('resize', function() {ldelim} update() {rdelim});
                    {rdelim}

                    layout.start();
                {rdelim});
            {/if}
    	</script>
    {/material_submenu}
{/material_menu_item}
