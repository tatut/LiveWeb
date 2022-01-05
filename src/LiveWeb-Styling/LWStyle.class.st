Class {
	#name : #LWStyle,
	#superclass : #Object,
	#instVars : [
		'out',
		'first'
	],
	#category : #'LiveWeb-Styling'
}

{ #category : #compiling }
LWStyle class >> compileCSSProperties [ 
  #('align-content' 'align-items' 'align-self' 'all' 'animation' 'animation-delay'
    'animation-direction' 'animation-duration' 'animation-fill-mode' 'animation-iteration-count'
    'animation-name' 'animation-play-state' 'animation-timing-function'
    'backface-visibility' 'background' 'background-attachment' 'background-blend-mode'
    'background-clip' 'background-color' 'background-image' 'background-origin' 'background-position'
    'background-repeat' 'background-size' 'border' 'border-bottom' 'border-bottom-color'
    'border-bottom-left-radius' 'border-bottom-right-radius' 'border-bottom-style'
    'border-bottom-width' 'border-collapse' 'border-color' 'border-image' 'border-image-outset'
    'border-image-repeat' 'border-image-slice' 'border-image-source' 'border-image-width'
    'border-left' 'border-left-color' 'border-left-style' 'border-left-width' 'border-radius'
    'border-right' 'border-right-color' 'border-right-style' 'border-right-width' 'border-spacing'
    'border-style' 'border-top' 'border-top-color' 'border-top-left-radius'
    'border-top-right-radius' 'border-top-style' 'border-top-width' 'border-width' 'bottom'
    'box-decoration-break' 'box-shadow' 'box-sizing' 'break-after' 'break-before' 'break-inside'
    'caption-side' 'caret-color' '@charset' 'clear' 'clip' 'color' 'column-count' 'column-fill'
    'column-gap' 'column-rule' 'column-rule-color' 'column-rule-style' 'column-rule-width'
    'column-span' 'column-width' 'columns' 'content' 'counter-increment' 'counter-reset' 'cursor'
    'direction' 'display'
    'empty-cells'
    'filter' 'flex' 'flex-basis' 'flex-direction' 'flex-flow' 'flex-grow' 'flex-shrink' 'flex-wrap'
    'float' 'font' '@font-face' 'font-family' 'font-feature-settings' '@font-feature-values'
    'font-kerning' 'font-language-override' 'font-size' 'font-size-adjust' 'font-stretch'
    'font-style' 'font-synthesis' 'font-variant' 'font-variant-alternates' 'font-variant-caps'
    'font-variant-east-asian' 'font-variant-ligatures' 'font-variant-numeric'
    'font-variant-position' 'font-weight'
    'gap' 'grid' 'grid-area' 'grid-auto-columns' 'grid-auto-flow' 'grid-auto-rows' 'grid-column'
    'grid-column-end' 'grid-column-gap' 'grid-column-start' 'grid-gap' 'grid-row' 'grid-row-end'
    'grid-row-gap' 'grid-row-start' 'grid-template' 'grid-template-areas' 'grid-template-columns'
    'grid-template-rows'
    'hanging-punctuation' 'height' 'hyphens'
    'image-rendering' '@import' 'isolation'
    'justify-content'
    '@keyframes'
    'left' 'letter-spacing' 'line-break' 'line-height' 'list-style' 'list-style-image'
    'list-style-position' 'list-style-type'
    'margin' 'margin-bottom' 'margin-left' 'margin-right' 'margin-top' 'mask' 'mask-clip'
    'mask-composite' 'mask-image' 'mask-mode' 'mask-origin' 'mask-position' 'mask-repeat'
    'mask-size' 'mask-type' 'max-height' 'max-width' '@media' 'min-height' 'min-width'
    'mix-blend-mode'
    'object-fit' 'object-position' 'opacity' 'order' 'orphans' 'outline' 'outline-color'
    'outline-offset' 'outline-style' 'outline-width' 'overflow' 'overflow-wrap' 'overflow-x'
    'overflow-y'
    'padding' 'padding-bottom' 'padding-left' 'padding-right' 'padding-top' 'page-break-after'
    'page-break-before' 'page-break-inside' 'perspective' 'perspective-origin' 'pointer-events'
    'position'
    'quotes'
    'resize' 'right' 'row-gap'
    'scroll-behavior'
    'tab-size' 'table-layout' 'text-align' 'text-align-last' 'text-combine-upright'
    'text-decoration' 'text-decoration-color' 'text-decoration-line' 'text-decoration-style'
    'text-indent' 'text-justify' 'text-orientation' 'text-overflow' 'text-shadow' 'text-transform'
    'text-underline-position' 'top' 'transform' 'transform-origin' 'transform-style' 'transition'
    'transition-delay' 'transition-duration' 'transition-property' 'transition-timing-function'
    'unicode-bidi' 'user-select'
    'vertical-align' 'visibility'
    'white-space' 'widows' 'width' 'word-break' 'word-spacing' 'word-wrap' 'writing-mode'
    'z-index' ) do: [ :prop | self compileCSSProperty: prop ].

  #('alignment-baseline'
    'baseline-shift'
    'clip' 'clip-path' 'clip-rule' 'color-interpolation' 'color-interpolation-filters'
    'color-profile' 'color-rendering'
    'dominant-baseline'
    'enable-background'
    'fill' 'fill-opacity' 'fill-rule' 'filter' 'flood-color' 'flood-opacity'
    'glyph-orientation-horizontal' 'glyph-orientation-vertical'
    'image-rendering'
    'kerning'
    'lighting-color'
    'marker' 'marker-end' 'marker-mid' 'marker-start' 'mask'
    'opacity'
    'pointer-events'
    'shape-rendering' 'stop-color' 'stop-opacity' 'stroke' 'stroke-dasharray' 'stroke-dashoffset'
    'stroke-linecap' 'stroke-linejoin' 'stroke-miterlimit' 'stroke-opacity' 'stroke-width'
    'text-anchor' 'text-rendering' ) do: [ :prop | self compileCSSProperty: prop ].
]

{ #category : #compiling }
LWStyle class >> compileCSSProperty: prop [
	| n s |
	(prop at: 1) = $@ ifTrue: [ ^ nil ]. "these are selectors, not properties"
	s := prop splitOn:'-'.
	n := s first, ('' join: (s allButFirst collect: #capitalized)), ':'.
	self compile: n,' value
	  self render: ''',prop,''' value: value'.
	self organization classify: n asSymbol  under: 'autogenerated rendering'
]

{ #category : #'instance creation' }
LWStyle class >> on: out [
	^ self new out: out; yourself.
]

{ #category : #'autogenerated rendering' }
LWStyle >> alignContent: value [
	  self render: 'align-content' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> alignItems: value [
	  self render: 'align-items' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> alignSelf: value [
	  self render: 'align-self' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> alignmentBaseline: value [
	  self render: 'alignment-baseline' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> all: value [
	  self render: 'all' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> animation: value [
	  self render: 'animation' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> animationDelay: value [
	  self render: 'animation-delay' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> animationDirection: value [
	  self render: 'animation-direction' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> animationDuration: value [
	  self render: 'animation-duration' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> animationFillMode: value [
	  self render: 'animation-fill-mode' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> animationIterationCount: value [
	  self render: 'animation-iteration-count' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> animationName: value [
	  self render: 'animation-name' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> animationPlayState: value [
	  self render: 'animation-play-state' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> animationTimingFunction: value [
	  self render: 'animation-timing-function' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> backfaceVisibility: value [
	  self render: 'backface-visibility' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> background: value [
	  self render: 'background' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> backgroundAttachment: value [
	  self render: 'background-attachment' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> backgroundBlendMode: value [
	  self render: 'background-blend-mode' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> backgroundClip: value [
	  self render: 'background-clip' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> backgroundColor: value [
	  self render: 'background-color' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> backgroundImage: value [
	  self render: 'background-image' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> backgroundOrigin: value [
	  self render: 'background-origin' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> backgroundPosition: value [
	  self render: 'background-position' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> backgroundRepeat: value [
	  self render: 'background-repeat' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> backgroundSize: value [
	  self render: 'background-size' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> baselineShift: value [
	  self render: 'baseline-shift' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> border: value [
	  self render: 'border' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderBottom: value [
	  self render: 'border-bottom' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderBottomColor: value [
	  self render: 'border-bottom-color' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderBottomLeftRadius: value [
	  self render: 'border-bottom-left-radius' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderBottomRightRadius: value [
	  self render: 'border-bottom-right-radius' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderBottomStyle: value [
	  self render: 'border-bottom-style' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderBottomWidth: value [
	  self render: 'border-bottom-width' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderCollapse: value [
	  self render: 'border-collapse' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderColor: value [
	  self render: 'border-color' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderImage: value [
	  self render: 'border-image' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderImageOutset: value [
	  self render: 'border-image-outset' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderImageRepeat: value [
	  self render: 'border-image-repeat' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderImageSlice: value [
	  self render: 'border-image-slice' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderImageSource: value [
	  self render: 'border-image-source' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderImageWidth: value [
	  self render: 'border-image-width' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderLeft: value [
	  self render: 'border-left' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderLeftColor: value [
	  self render: 'border-left-color' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderLeftStyle: value [
	  self render: 'border-left-style' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderLeftWidth: value [
	  self render: 'border-left-width' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderRadius: value [
	  self render: 'border-radius' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderRight: value [
	  self render: 'border-right' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderRightColor: value [
	  self render: 'border-right-color' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderRightStyle: value [
	  self render: 'border-right-style' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderRightWidth: value [
	  self render: 'border-right-width' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderSpacing: value [
	  self render: 'border-spacing' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderStyle: value [
	  self render: 'border-style' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderTop: value [
	  self render: 'border-top' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderTopColor: value [
	  self render: 'border-top-color' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderTopLeftRadius: value [
	  self render: 'border-top-left-radius' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderTopRightRadius: value [
	  self render: 'border-top-right-radius' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderTopStyle: value [
	  self render: 'border-top-style' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderTopWidth: value [
	  self render: 'border-top-width' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> borderWidth: value [
	  self render: 'border-width' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> bottom: value [
	  self render: 'bottom' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> boxDecorationBreak: value [
	  self render: 'box-decoration-break' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> boxShadow: value [
	  self render: 'box-shadow' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> boxSizing: value [
	  self render: 'box-sizing' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> breakAfter: value [
	  self render: 'break-after' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> breakBefore: value [
	  self render: 'break-before' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> breakInside: value [
	  self render: 'break-inside' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> captionSide: value [
	  self render: 'caption-side' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> caretColor: value [
	  self render: 'caret-color' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> clear: value [
	  self render: 'clear' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> clip: value [
	  self render: 'clip' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> clipPath: value [
	  self render: 'clip-path' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> clipRule: value [
	  self render: 'clip-rule' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> color: value [
	  self render: 'color' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> colorInterpolation: value [
	  self render: 'color-interpolation' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> colorInterpolationFilters: value [
	  self render: 'color-interpolation-filters' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> colorProfile: value [
	  self render: 'color-profile' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> colorRendering: value [
	  self render: 'color-rendering' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> columnCount: value [
	  self render: 'column-count' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> columnFill: value [
	  self render: 'column-fill' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> columnGap: value [
	  self render: 'column-gap' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> columnRule: value [
	  self render: 'column-rule' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> columnRuleColor: value [
	  self render: 'column-rule-color' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> columnRuleStyle: value [
	  self render: 'column-rule-style' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> columnRuleWidth: value [
	  self render: 'column-rule-width' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> columnSpan: value [
	  self render: 'column-span' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> columnWidth: value [
	  self render: 'column-width' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> columns: value [
	  self render: 'columns' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> content: value [
	  self render: 'content' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> counterIncrement: value [
	  self render: 'counter-increment' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> counterReset: value [
	  self render: 'counter-reset' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> cursor: value [
	  self render: 'cursor' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> direction: value [
	  self render: 'direction' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> display: value [
	  self render: 'display' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> dominantBaseline: value [
	  self render: 'dominant-baseline' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> emptyCells: value [
	  self render: 'empty-cells' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> enableBackground: value [
	  self render: 'enable-background' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fill: value [
	  self render: 'fill' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fillOpacity: value [
	  self render: 'fill-opacity' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fillRule: value [
	  self render: 'fill-rule' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> filter: value [
	  self render: 'filter' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> flex: value [
	  self render: 'flex' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> flexBasis: value [
	  self render: 'flex-basis' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> flexDirection: value [
	  self render: 'flex-direction' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> flexFlow: value [
	  self render: 'flex-flow' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> flexGrow: value [
	  self render: 'flex-grow' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> flexShrink: value [
	  self render: 'flex-shrink' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> flexWrap: value [
	  self render: 'flex-wrap' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> float: value [
	  self render: 'float' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> floodColor: value [
	  self render: 'flood-color' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> floodOpacity: value [
	  self render: 'flood-opacity' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> font: value [
	  self render: 'font' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontFamily: value [
	  self render: 'font-family' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontFeatureSettings: value [
	  self render: 'font-feature-settings' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontKerning: value [
	  self render: 'font-kerning' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontLanguageOverride: value [
	  self render: 'font-language-override' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontSize: value [
	  self render: 'font-size' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontSizeAdjust: value [
	  self render: 'font-size-adjust' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontStretch: value [
	  self render: 'font-stretch' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontStyle: value [
	  self render: 'font-style' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontSynthesis: value [
	  self render: 'font-synthesis' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontVariant: value [
	  self render: 'font-variant' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontVariantAlternates: value [
	  self render: 'font-variant-alternates' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontVariantCaps: value [
	  self render: 'font-variant-caps' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontVariantEastAsian: value [
	  self render: 'font-variant-east-asian' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontVariantLigatures: value [
	  self render: 'font-variant-ligatures' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontVariantNumeric: value [
	  self render: 'font-variant-numeric' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontVariantPosition: value [
	  self render: 'font-variant-position' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> fontWeight: value [
	  self render: 'font-weight' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gap: value [
	  self render: 'gap' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> glyphOrientationHorizontal: value [
	  self render: 'glyph-orientation-horizontal' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> glyphOrientationVertical: value [
	  self render: 'glyph-orientation-vertical' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> grid: value [
	  self render: 'grid' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridArea: value [
	  self render: 'grid-area' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridAutoColumns: value [
	  self render: 'grid-auto-columns' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridAutoFlow: value [
	  self render: 'grid-auto-flow' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridAutoRows: value [
	  self render: 'grid-auto-rows' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridColumn: value [
	  self render: 'grid-column' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridColumnEnd: value [
	  self render: 'grid-column-end' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridColumnGap: value [
	  self render: 'grid-column-gap' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridColumnStart: value [
	  self render: 'grid-column-start' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridGap: value [
	  self render: 'grid-gap' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridRow: value [
	  self render: 'grid-row' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridRowEnd: value [
	  self render: 'grid-row-end' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridRowGap: value [
	  self render: 'grid-row-gap' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridRowStart: value [
	  self render: 'grid-row-start' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridTemplate: value [
	  self render: 'grid-template' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridTemplateAreas: value [
	  self render: 'grid-template-areas' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridTemplateColumns: value [
	  self render: 'grid-template-columns' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> gridTemplateRows: value [
	  self render: 'grid-template-rows' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> hangingPunctuation: value [
	  self render: 'hanging-punctuation' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> height: value [
	  self render: 'height' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> hyphens: value [
	  self render: 'hyphens' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> imageRendering: value [
	  self render: 'image-rendering' value: value
]

{ #category : #initialization }
LWStyle >> initialize [ 
	first := true

]

{ #category : #'autogenerated rendering' }
LWStyle >> isolation: value [
	  self render: 'isolation' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> justifyContent: value [
	  self render: 'justify-content' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> kerning: value [
	  self render: 'kerning' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> left: value [
	  self render: 'left' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> letterSpacing: value [
	  self render: 'letter-spacing' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> lightingColor: value [
	  self render: 'lighting-color' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> lineBreak: value [
	  self render: 'line-break' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> lineHeight: value [
	  self render: 'line-height' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> listStyle: value [
	  self render: 'list-style' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> listStyleImage: value [
	  self render: 'list-style-image' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> listStylePosition: value [
	  self render: 'list-style-position' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> listStyleType: value [
	  self render: 'list-style-type' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> margin: value [
	  self render: 'margin' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> marginBottom: value [
	  self render: 'margin-bottom' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> marginLeft: value [
	  self render: 'margin-left' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> marginRight: value [
	  self render: 'margin-right' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> marginTop: value [
	  self render: 'margin-top' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> marker: value [
	  self render: 'marker' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> markerEnd: value [
	  self render: 'marker-end' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> markerMid: value [
	  self render: 'marker-mid' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> markerStart: value [
	  self render: 'marker-start' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> mask: value [
	  self render: 'mask' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> maskClip: value [
	  self render: 'mask-clip' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> maskComposite: value [
	  self render: 'mask-composite' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> maskImage: value [
	  self render: 'mask-image' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> maskMode: value [
	  self render: 'mask-mode' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> maskOrigin: value [
	  self render: 'mask-origin' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> maskPosition: value [
	  self render: 'mask-position' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> maskRepeat: value [
	  self render: 'mask-repeat' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> maskSize: value [
	  self render: 'mask-size' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> maskType: value [
	  self render: 'mask-type' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> maxHeight: value [
	  self render: 'max-height' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> maxWidth: value [
	  self render: 'max-width' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> minHeight: value [
	  self render: 'min-height' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> minWidth: value [
	  self render: 'min-width' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> mixBlendMode: value [
	  self render: 'mix-blend-mode' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> objectFit: value [
	  self render: 'object-fit' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> objectPosition: value [
	  self render: 'object-position' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> opacity: value [
	  self render: 'opacity' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> order: value [
	  self render: 'order' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> orphans: value [
	  self render: 'orphans' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> outline: value [
	  self render: 'outline' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> outlineColor: value [
	  self render: 'outline-color' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> outlineOffset: value [
	  self render: 'outline-offset' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> outlineStyle: value [
	  self render: 'outline-style' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> outlineWidth: value [
	  self render: 'outline-width' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> overflow: value [
	  self render: 'overflow' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> overflowWrap: value [
	  self render: 'overflow-wrap' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> overflowX: value [
	  self render: 'overflow-x' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> overflowY: value [
	  self render: 'overflow-y' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> padding: value [
	  self render: 'padding' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> paddingBottom: value [
	  self render: 'padding-bottom' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> paddingLeft: value [
	  self render: 'padding-left' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> paddingRight: value [
	  self render: 'padding-right' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> paddingTop: value [
	  self render: 'padding-top' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> pageBreakAfter: value [
	  self render: 'page-break-after' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> pageBreakBefore: value [
	  self render: 'page-break-before' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> pageBreakInside: value [
	  self render: 'page-break-inside' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> perspective: value [
	  self render: 'perspective' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> perspectiveOrigin: value [
	  self render: 'perspective-origin' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> pointerEvents: value [
	  self render: 'pointer-events' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> position: value [
	  self render: 'position' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> quotes: value [
	  self render: 'quotes' value: value
]

{ #category : #rendering }
LWStyle >> render: cssPropertyName value: value [
   first ifTrue: [ first := false ] ifFalse: [ out nextPutAll: '; ' ].
	out nextPutAll: cssPropertyName; nextPutAll: ': '; nextPutAll: value asCSSPropertyValue 
]

{ #category : #'autogenerated rendering' }
LWStyle >> resize: value [
	  self render: 'resize' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> right: value [
	  self render: 'right' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> rowGap: value [
	  self render: 'row-gap' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> scrollBehavior: value [
	  self render: 'scroll-behavior' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> shapeRendering: value [
	  self render: 'shape-rendering' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> stopColor: value [
	  self render: 'stop-color' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> stopOpacity: value [
	  self render: 'stop-opacity' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> stroke: value [
	  self render: 'stroke' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> strokeDasharray: value [
	  self render: 'stroke-dasharray' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> strokeDashoffset: value [
	  self render: 'stroke-dashoffset' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> strokeLinecap: value [
	  self render: 'stroke-linecap' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> strokeLinejoin: value [
	  self render: 'stroke-linejoin' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> strokeMiterlimit: value [
	  self render: 'stroke-miterlimit' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> strokeOpacity: value [
	  self render: 'stroke-opacity' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> strokeWidth: value [
	  self render: 'stroke-width' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> tabSize: value [
	  self render: 'tab-size' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> tableLayout: value [
	  self render: 'table-layout' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> textAlign: value [
	  self render: 'text-align' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> textAlignLast: value [
	  self render: 'text-align-last' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> textAnchor: value [
	  self render: 'text-anchor' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> textCombineUpright: value [
	  self render: 'text-combine-upright' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> textDecoration: value [
	  self render: 'text-decoration' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> textDecorationColor: value [
	  self render: 'text-decoration-color' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> textDecorationLine: value [
	  self render: 'text-decoration-line' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> textDecorationStyle: value [
	  self render: 'text-decoration-style' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> textIndent: value [
	  self render: 'text-indent' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> textJustify: value [
	  self render: 'text-justify' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> textOrientation: value [
	  self render: 'text-orientation' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> textOverflow: value [
	  self render: 'text-overflow' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> textRendering: value [
	  self render: 'text-rendering' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> textShadow: value [
	  self render: 'text-shadow' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> textTransform: value [
	  self render: 'text-transform' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> textUnderlinePosition: value [
	  self render: 'text-underline-position' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> top: value [
	  self render: 'top' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> transform: value [
	  self render: 'transform' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> transformOrigin: value [
	  self render: 'transform-origin' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> transformStyle: value [
	  self render: 'transform-style' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> transition: value [
	  self render: 'transition' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> transitionDelay: value [
	  self render: 'transition-delay' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> transitionDuration: value [
	  self render: 'transition-duration' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> transitionProperty: value [
	  self render: 'transition-property' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> transitionTimingFunction: value [
	  self render: 'transition-timing-function' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> unicodeBidi: value [
	  self render: 'unicode-bidi' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> userSelect: value [
	  self render: 'user-select' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> verticalAlign: value [
	  self render: 'vertical-align' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> visibility: value [
	  self render: 'visibility' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> whiteSpace: value [
	  self render: 'white-space' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> widows: value [
	  self render: 'widows' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> width: value [
	  self render: 'width' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> wordBreak: value [
	  self render: 'word-break' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> wordSpacing: value [
	  self render: 'word-spacing' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> wordWrap: value [
	  self render: 'word-wrap' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> writingMode: value [
	  self render: 'writing-mode' value: value
]

{ #category : #'autogenerated rendering' }
LWStyle >> zIndex: value [
	  self render: 'z-index' value: value
]
