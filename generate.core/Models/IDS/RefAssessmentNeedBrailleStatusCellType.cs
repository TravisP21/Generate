﻿using System;
using System.Collections.Generic;

namespace generate.core.Models.IDS
{
    public partial class RefAssessmentNeedBrailleStatusCellType
    {
        public RefAssessmentNeedBrailleStatusCellType()
        {
            AssessmentNeedBraille = new HashSet<AssessmentNeedBraille>();
        }

        public int RefAssessmentNeedBrailleStatusCellTypeId { get; set; }
        public string Description { get; set; }
        public string Code { get; set; }
        public string Definition { get; set; }
        public int? RefJurisdictionId { get; set; }
        public decimal? SortOrder { get; set; }

        public virtual ICollection<AssessmentNeedBraille> AssessmentNeedBraille { get; set; }
        public virtual Organization RefJurisdiction { get; set; }
    }
}